local M = {}
dg_vault_path = ""
def_opts = {
  args = "",
  bang = false,
  count = -1,
  fargs = {},
  line1 = 1,
  line2 = 1,
  mods = "",
  range = 0,
  reg = "",
  smods = {
    browse = false,
    confirm = false,
    emsg_silent = false,
    hide = false,
    horizontal = false,
    keepalt = false,
    keepjumps = false,
    keepmarks = false,
    keeppatterns = false,
    lockmarks = false,
    noautocmd = false,
    noswapfile = false,
    sandbox = false,
    silent = false,
    split = "",
    tab = -1,
    unsilent = false,
    verbose = -1,
    vertical = false
  }
}


M.hello = function()
    print("hello from dragonglass")
end

M.setup = function(opts)
    print("Options: ", opts)
    dg_vault_path = opts.path
    print("path set to: ", dg_vault_path)
end

M.win = function()
    require("glow").execute(def_opts)
    -- local buf = vim.api.nvim_create_buf(false, true)
    -- vim.api.nvim_open_win(buf, false, {relative='win', row=3, col=3, width=12, height=3})
end

        

return M
