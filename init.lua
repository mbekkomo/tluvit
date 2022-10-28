_G.require = require
module, import = require('import')(module)

local fs = require 'fs'
local C = require 'ansicolorsx'

local function pC(...)
	print(C(table.concat({...},'\t')))
end

--[[
 A Teal (.tl) runner for Luvit runtime
]]
local tluvit = {}

--[[
Where the module should get the "tl.lua"
]]
tluvit.tlpath = ''


local function checktl()
  package.path = package.path..(
		tluvit.tlpath ~= '' or tluvit.tlpath:match '^%s+$' and
		';'..tluvit.tlpath or '')
  local exist,tl = pcall(require,'tl')

  if not exist then
    pC([[%{red}Cannot find "tl" module inside package.path!%{reset}
%{yellow}]]..(';'..package.path):gsub(';','\n- '))
    os.exit(1)
  end

  return tl
end

tluvit.api = checktl()

--[[
<s>
Load or require a .tl file. If the file returns something, this function also returnthe returned value in the .tl file.
]]
---@param path string? The path to .tl, defaults to "./main.tl"
---@param notc boolean? Disable typechecking, defaults to "false"
---@return any module The return of the .tl
function tluvit.loadtl(path,notc)
  path = path or './main.tl'

  if not fs.existsSync(path) then
    error('Path to the .tl is not exist!')
  end

  local tl = tluvit.api

  local tlfile = fs.readFileSync(path)
	local filename = path:gsub('^(.-/)','') or path

  local mdl,err = tl.load(tlfile,filename,notc and 't' or 'ct')

  if not mdl and err then
    error(C('\n%{red reverse}'..err))
  end

  return mdl ~= nil and mdl() or mdl
end

return tluvit
