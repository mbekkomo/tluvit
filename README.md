# tluvit
A Teal (.tl) runner for the Luvit Runtime

## Usage
```lua
local tluvit = require('tluvit')

tluvit.loadtl('path/to/script-without-file-extension')
```

If you get an error like this:
```
Cannot find "tl" module inside package.path!!

"package.path" content:
- ./?.lua
- /usr/local/share/luajit-2.1.0-beta3/?.lua
- /usr/local/share/lua/5.1/?.lua
- /usr/local/share/lua/5.1/?/init.lua
- ./deps/?.lua
- ./deps/?/init.lua
```

You can configure the path by changing the value in `tluvit.loadpath`
```lua
local tluvit = require('tluvit')

-- Follows up package.path rule
tluvit.loadpath = '/usr/local/share/lua/5.4/tl.lua'
tluvit.loadpath = tluvit.loadpath..';'..os.getenv('HOME')..'.luarocks/share/5.1/tl.lua'

tluvit.loadtl('./main')
```
