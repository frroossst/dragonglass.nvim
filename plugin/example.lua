print("hello from plugin")

vim.keymap.set("n", "<F12>", ":echo 'could not resolve link'<CR>")

require("dg").win()
