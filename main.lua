local cu = require 'custom-utils'

local pC,wC,shiftarg = cu.pC, cu.wC, cu.shiftarg

local startRepl = false
local showUsage = false
local argcopy = {}
for i,v in pairs(args) do
	argcopy[i] = v
end

local function usage()
	pC[[
Usage: tluvit <%{red}command%{reset}> [%{blue}fields...%{reset}]

Command:
 • Help 					Show this %{green}message%{reset}
]]
end

usage()
shiftarg(2)
p(args)
