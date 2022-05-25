local present, nvimtree = pcall(require, "nvim-tree")
if not present then
  return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback

-- Set alias for vim.g.
local g = vim.g

g.nvim_tree_auto_ignore_ft = { "alpha" } -- Don't open tree on specific fiypes.
g.nvim_tree_git_hl = 1 -- Will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 0 -- Will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_add_trailing = 0 -- Append a trailing slash to folder names. ]]

local nvimtree_config = {
  open_on_tab = true,
  update_cwd = true,
  disable_netrw = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = "!",
      info = "i",
      warning = "!",
      error = "x",
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  filters = {
    custom = {
      ".git",
      "node_modules",
      ".cache",
      "__pycache__",
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  view = {
    width = vim.fn.winwidth(0),
    side = "left",
    preserve_window_proportions = false,
    mappings = {
      list = {
      },
    },
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = {
            "notify",
            "packer",
            "qf",
            "diff",
            "fugitive",
            "fugitiveblame",
            "Outline",
            "toggleterm",
          },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
}

nvimtree.setup(nvimtree_config)
