local function readfile(path)
    return module:load(path)
end

local bootstrap_require_cache = {}

local content_import = readfile('import.lua')
local content_fs = readfile('fs/init.lua')
local content_fs_path = readfile('fs/path.lua')

local function bootstrap_import(name, content)
    if bootstrap_require_cache[name] then
        return bootstrap_require_cache[name]
    end

    if not content then
        return error('bootstrap import: attempt to require unloaded module ' .. name)
    end

    local env = setmetatable({
        module = { fake = true },
        import = bootstrap_import,
    }, { __index = _G })

    local fn, err = load(content, 'bootstrap:/' .. name, 't', env)
    if not fn then
        error('bootstrap failure: syn: ' .. err)
    end

    local success, result = pcall(fn)

    if not success then
        error('bootstrap failure: run: ' .. result)
    end

    bootstrap_require_cache[name] = result

    return bootstrap_require_cache[name]
end

bootstrap_import('path.lua', content_fs_path)
bootstrap_import('fs/init.lua', content_fs)
local import = bootstrap_import('import.lua', content_import)

return function(module)
    local mod = import.new(module.path, module.path:find('^bundle:'))

    return mod, function(...)
        return mod:import(...)
    end
end
