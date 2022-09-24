--[[lit-meta
  name = "UrNightmaree/tluvit"
  version = "1.3"
  description = "A Teal (.tl) runner for the Luvit runtime"
  tags = { "luvit", "teal" }
  license = "MIT"
  author = "UrNightmaree"
  homepage = "https://github.com/UrNightmaree/tluvit"
]]

_G.lua_require = require
_G.require = require
module, import = require('import')(module)

local HOME = os.getenv'HOME'

--[[
 A Teal (.tl) runner for Luvit runtime
]]
local tluvit = {}

--[[
Where the module should get the "tl.lua"
]]
tluvit.tlpath = ';'..HOME..'/.luarocks/share/lua/5.1/?.lua;'..HOME..'/.luarocks/share/lua/5.1/?/init.lua'


local checktl = function()
  package.path = package.path..';'..tluvit.loadpath

  local exist,tl = pcall(lua_require,'tl')

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
---@param path string? The path to .tl, defaults to "./maintl(.tl)"
---@return any module The return of the .tl
tluvit.loadtl = function(path)
  path = path or 'maintl'

  local tl = checktl()
  tl.loader()

  package.path = './deps/?.lua;./deps/?/init.lua;./?/init.lua;./?/init.tl;./deps/?.tl;./deps/?/init.tl;'..package.path

  local ok,mdl = pcall(lua_require,path)

  if not ok and mdl then
    print '\27[1;31mAn error has occurred while running the .tl!\n'
    print 'The error:\27[0m'
    print('\27[37;41m'..err..'\27[0m')
    os.exit(1)
  elseif ok and mdl then
    return mdl
  end
end

return tluvit
