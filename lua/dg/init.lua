local M = {}
dg_vault_path = ""

M.hello = function()
    print("hello from dragonglass")
end

M.setup = function(opts)
    print("Options: ", opts)
    dg_vault_path = opts.path
    print("path set to: ", dg_vault_path)
end

return M
