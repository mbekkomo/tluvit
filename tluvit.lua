--[[lit-meta
  name = "UrNightmaree/tluvit"
  version = "1.2"
  description = "A Teal (.tl) runner for the Luvit runtime"
  tags = { "luvit", "teal" }
  license = "MIT"
  author = "UrNightmaree"
  homepage = "https://github.com/UrNightmaree/tluvit"
]]

local HOME = os.getenv'HOME'

local tluvit = {}

--[[
"tluvit.loadpath" is a variable that will define the "tl" module path
]]
tluvit.loadpath = ';'..HOME..'/.luarocks/share/lua/5.1/?.lua;'..HOME..'/.luarocks/share/lua/5.1/?/init.lua'

--[[
<s>
"tluvit.loadtl" is a function that'll load a .tl file
<s>
Example:
<s>
```lua
--SOF--
local tluvit = require 'tluvit'
<s>
tluvit.loadtl('main') -- This will automatically translated to "main.tl"
--EOF--
```
]]
---@param path string path/to/script.tl
tluvit.loadtl = function(path)
  package.path = package.path..';'..tluvit.loadpath

  local tl

  local exist = pcall(function()
    tl = require 'tl'
  end)

  if not exist then
    print '\27[1;31mCannot find "tl" module inside package.path!!\n'
    print '"package.path" content:\27[0m'
    print('\27[33m- '..string.gsub(package.path,';','\n- ')..'\27[0m')
    os.exit(1)
  end

  tl.loader()
  package.path = './deps/?.lua;./deps/?/init.lua;./?/init.lua;./?/init.tl;./deps/?.tl;./deps/?/init.tl;'..package.path

  local ok,err = pcall(function()
    require(path)
  end)

  if not ok and err then
    print '\27[1;31mAn error has occurred while running the .tl!\n'
    print 'The error:\27[0m'
    print('\27[37;41m'..err..'\27[0m')
    os.exit(1)
  end
end

return tluvit
