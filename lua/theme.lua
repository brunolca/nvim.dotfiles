-- Hide ~ from end of lines.
vim.opt.fillchars = { eob = " " }

local highlight = require("utils").highlight

-- -- Highlightign line number for lsp diagnostics sings based on colorscheme
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  pattern = "*",

  callback = function()
    local fn = vim.fn

    -- Getting diagnostic signs color.
    local error_bcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignError")), "fg")
    local info_bcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignInfo")), "fg")
    local warn_bcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignWarn")), "fg")
    local hint_bcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignHint")), "fg")

    local error_fcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignError")), "bg")
    local info_fcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignInfo")), "bg")
    local warn_fcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignWarn")), "bg")
    local hint_fcolor = fn.synIDattr(fn.synIDtrans(fn.hlID("DiagnosticSignHint")), "bg")

    -- Applying thoes colors to diagnostic line number.
    highlight("DiagnosticLineNrError", { bg = error_bcolor, fg = error_fcolor }, { bold = true })
    highlight("DiagnosticLineNrWarn", { bg = warn_bcolor, fg = warn_fcolor }, { bold = true })
    highlight("DiagnosticLineNrInfo", { bg = info_bcolor, fg = info_fcolor }, { bold = true })
    highlight("DiagnosticLineNrHint", { bg = hint_bcolor, fg = hint_fcolor }, { bold = true })

    -- Applying diagnostic line number and remove diagnostic signs
    fn.sign_define("DiagnosticSignError", { text = "", texthl = "", numhl = "DiagnosticLineNrError" })
    fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "", numhl = "DiagnosticLineNrWarn" })
    fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "", numhl = "DiagnosticLineNrInfo" })
    fn.sign_define("DiagnosticSignHint", { text = "", texthl = "", numhl = "DiagnosticLineNrHint" })
  end,
})

vim.api.nvim_command(":colorscheme github_dark_default")
