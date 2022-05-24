local present, lualine_setup = pcall(require, "lualine")
if not present then
  return
end

local utils = require("plugins.lualine.components")

local lualine_config = {
  options = {
    globalstatus = true,
    theme = "auto",
    disabled_filetypes = {
      "TelescopePrompt",
      "TelescopeResults",
      "aerial",
      "dapui_scopes",
      "dapui_breakpoints",
      "dapui_stacks",
      "dapui_watches",
      "dap-repl",
    },
    section_separators = { left = " ", right = " " },
    component_separators = { left = "│", right = "│" },
  },
  extensions = { "fugitive", "nvim-tree", "toggleterm", "aerial", "quickfix", "symbols-outline" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch" },
      {
        "diff",
        -- symbols = { added = "+" modified = "~", removed = "-" }, -- changes diff symbols
      },
      { "diagnostics" },
    },
    lualine_c = {
      { "filetype", icon_only = true, padding = { left = 1, right = 0 }, separator = " " },
      { "filename", padding = { left = 0, right = 1 } },
    },
    lualine_x = {
      {
        utils.lsp_name,
        icon = " ",
        color = { gui = "none" },
      },
      {
        utils.treesitter_status,
        color = { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("DiffChange")), "fg") },
      },
      "fileformat",
    },
    lualine_y = { utils.lsp_progress, "progress" },
    lualine_z = { "location" },
  },
}

lualine_setup.setup(lualine_config)
