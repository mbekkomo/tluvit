> This loader is mentioned in [awesome-teal](https://github.com/teal-language/awesome-teal) repository, check it out!

# tluvit
A Teal (.tl) runner for the Luvit Runtime

## Usage
```lua
local tluvit = require("tluvit")

-- Path to the "tl.lua",
-- defaults to "" (none)
tluvit.tlpath = ""

-- Load the .tl into Luvit runtime
--
-- Argument #1 pass string of the filename (path),
-- defaults to "main.tl"
--
-- Argument #2 pass boolean if the loader
-- want to not do type checking (notc),
-- defaults to "false"
tluvit.loadtl("main.tl", false)
```
---
`tluvit` can also load a .tl module using `tluvit.loadtl`:
```lua
-- In main.lua
require("pretty-print")
local tluvit = require("tluvit")

local tlmodule = tluvit.loadtl("mylibs.tl")
-- You can also pass boolean on argument "notc"
-- to load the module without errors

p(tlmodule)
```
```
-- In mylibs.tl
local record Mylibs
  printHi: function()
  foo: string
end

local mylibs: Mylibs = {}

function mylibs.printHi()
  print("Hi")
end


mylibs.foo = "Foo!"

return mylibs
```
Output:
```
{ foo = 'Foo!', printHi = function: 0xe7cda370 }
```
