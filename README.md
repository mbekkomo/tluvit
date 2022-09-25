# tluvit
A Teal (.tl) runner for the Luvit Runtime

## Usage
Before version `tluvit@1.3.0`, you must define a path to the .tl:
```lua
local tluvit = require('tluvit')

tluvit.loadtl('path/to/script-without-file-extension')
```

After version `tluvit@1.3.0`, it is optional to not define the path to the .tl. It defaults to `./maintl.tl`.
```lua
local tluvit = require('tluvit')

tluvit.loadtl()
```
In version `tluvit@1.3.0` or above, you can now load .tl module using `tluvit.loadtl`.

In module.tl:
```tl
local mdl = {}

mdl.printHi = function()
  print('Hi!')
end)

mdl.Value = 'Teal Module!'

return mdl
```
In main.lua:
```lua
local tluvit = require 'tluvit'
tluvit.tlpath = '/usr/local/share/5.4/tl.lua'

local myModule = tluvit.loadtl('module')

myModule.printHi()
print(myModule.Value)
```

Output:
```
Hi!
Teal Module!
```

## Troubleshooting
### Got an error about Tluvit can't find "tl" module
If you got an error like this:
```
Cannot find "tl" module inside package.path!!

"package.path" content:
- ./?.lua
- /usr/local/share/luajit-2.1.0-beta3/?.lua
- /usr/local/share/lua/5.1/?.lua
- /usr/local/share/lua/5.1/?/init.lua
```
You can configure the path by changing the value in `tluvit.loadpath` (before `tluvit@1.3.0`):
```lua
local tluvit = require('tluvit')

tluvit.loadpath = '/usr/local/share/lua/5.4/tl.lua'

tluvit.loadtl('./maintl')
```
If you're using latest module (after `tluvit@1.2.0`), you need to use `tluvit.tlpath` instead using `tluvit.loadpath`
```lua
local tluvit = require('tluvit')

tluvit.tlpath = '/usr/local/share/lua/5.4/tl.lua'

tluvit.loadtl()
```

### Got an error about module "import" not found
This error is related to missing dependency in version `tluvit >= 1.3.0, < 1.3.2`, you can install `truemedian/import`.
```
lit install truemedian/import
```

If all of the troubleshooting doesn't fix your problem, you can post an [**issue**](https://github.com/UrNightmaree/tluvit/issues/new) about your problem.
