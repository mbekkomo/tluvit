--[[lit-meta
  name = "UrNightmaree/tluvit"
  version = "1.5"
  description = "A Teal (.tl) runner for the Luvit runtime"
  tags = { "luvit", "teal" }
  dependencies = {
    'truemedian/import',
    'luvit/fs'
  }
  license = "MIT"
  author = "UrNightmaree"
  homepage = "https://github.com/UrNightmaree/tluvit"
]]

package.path = package.path..';./?/init.lua'

_G.require = require
module, import = require('import')(module)

local fs = require 'fs'

--[[
 A Teal (.tl) runner for Luvit runtime
]]
local tluvit = {}

--[[
Where the module should get the "tl.lua"
]]
tluvit.tlpath = ''


local checktl = function()
  package.path = package.path..';'..tluvit.tlpath
  local exist,tl = pcall(require,'tl')

  if not exist then
    print '\27[1;31mCannot find "tl" module inside package.path!!\n'
    print '"package.path" content:\27[0m'
    print('\27[33m- '..string.gsub(package.path,';','\n- ')..'\27[0m')
    os.exit(1)
  end

  return tl
end

--[[
<s>
Load or require a .tl file. If the file returns something, this function also returnthe returned value in the .tl file.
]]
---@param path string? The path to .tl, defaults to "./main.tl"
---@param notc boolean? Disable typechecking, defaults to "false"
---@return any module The return of the .tl
tluvit.loadtl = function(path,notc)
  path = path or './main.tl'

  if not fs.existsSync(path) then
    error('Path to the .tl is not exist!')
  end

  local tl = checktl()

  local tlmdl
  if not notc then
    local tlfile = fs.readFileSync(path)

    local mdl,err = tl.load(tlfile,'','ct')

    if not mdl and err then
      error('\n\27[31mAn error has occurred while running the .tl!\n\nThe error:\27[0m\n\27[41m'..err..'\27[0m')
    end

    tlmdl = mdl
  else
    path = path:gsub('%.tl$','')

    tl.loader()

    local ok,mdl = pcall(require,path)

    if not ok and mdl then
      error('\n\27[31mAn error has occurred while running the .tl!\n\nThe error:\27[0m\n\27[41m'..mdl..'\27[0m')
    end

    tlmdl = mdl
  end

  return tlmdl
end

return tluvit
