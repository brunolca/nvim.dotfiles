-- Function for make mapping easier.
local map = require("utils").map

-- Map leader key to space.
vim.g.mapleader = " "

-- split navigations.
map("n", "<A-j>", "<C-w><C-j>")
map("n", "<A-k>", "<C-w><C-k>")
map("n", "<A-l>", "<C-w><C-l>")
map("n", "<A-h>", "<C-w><C-h>")


-- Moving lines in visual select.
-- map("n", "<C-j>", ":move '>+1<CR>gv-gv")
-- map("n", "<C-k>", ":move '<-2<CR>gv-gv")
-- map("v", "<C-j>", ":move '>+1<CR>gv-gv")
-- map("v", "<c-k>", ":move '<-2<cr>gv-gv")

-- FzF commands history
map("c", "<c-r>", ":FzfLua command_history")

-- ToggleTerm
function _G.set_terminal_keymaps()
  map("t", "<esc>", "<C-\\><C-n>")
  map("t", "<A-h>", "<c-\\><c-n><c-w>h")
  map("t", "<A-j>", "<c-\\><c-n><c-w>j")
  map("t", "<A-k>", "<c-\\><c-n><c-w>k")
  map("t", "<A-l>", "<c-\\><c-n><c-w>l")
end
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    set_terminal_keymaps()
  end,
})

-- Don't copy the replaced text after pasting.
map("v", "p", '"_dP')
