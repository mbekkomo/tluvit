local C = require 'ansicolorsx'

local concat,remove = table.concat, table.remove
local write = io.write

local function shiftarg(idx)
	idx = idx or 1

	remove(args,idx)
end

local function pC(...)
	print(C(concat({...},'\t')))
end

local function wC(...)
	write(C(concat({...},'\t')))
end

return {
	shiftarg = shiftarg,
	pC = pC,
	wC = wC
}
