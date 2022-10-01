--[[lit-meta
  name = "UrNightmaree/tluvit"
  version = "1.4"
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

local fs = require 'fs'

_G.require = require
module, import = require('import')(module)

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
---@param path string? The path to .tl, defaults to "./maintl.tl"
---@return any module The return of the .tl
tluvit.loadtl = function(path,mode)
  path = path or './maintl.tl'
  mode = mode or 'ct'

  if not fs.existsSync(path) then
    error('Path to the .tl is not exist!')
  end

  local tl = checktl()

  local tlfile = fs.readFileSync(path)
  local mdl,err = tl.load(tlfile,path,mode)

  if not mdl and err then
    error('\n\27[31;1mAn error has occured while running '..path..'\n\n'..err)
  end

  return type(mdl) == "function" and mdl() or mdl
end

return tluvit
