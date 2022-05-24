local utils = require("utils")
local fn = vim.fn

-- Disable some builtin plugins.
local disabled_built_ins = {
  "2html_plugin",
  "gzip",
  "matchit",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "logipat",
  "spellfile_plugin",
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Install packer.nvim if it's not installed.
local packer_bootstrap
if not utils.is_plugin_installed("packer.nvim") then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    utils.plugins_path .. "/start/packer.nvim",
  })
  vim.cmd([[packadd packer.nvim]])
end

local use = require("packer").use

return require("packer").startup({
  function()
    use({ "wbthomason/packer.nvim" })

    -- These two plugins make CodeArt startup faster.
    -- In addition FixCursorHold can fix this bug:
    -- https://github.com/neovim/neovim/issues/12587
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    })
    use({
      "antoinemadec/FixCursorHold.nvim",
      event = { "BufRead", "BufNewFile" },
    })

    -- This plugin is needed for many plugins(like telescope) so this is one of
    -- default CodeArt's plugins.
    use({
      "nvim-lua/plenary.nvim",
    })

    -- Color schemes.
    use({
      'projekt0n/github-nvim-theme',
    })

    use({
      'ggandor/lightspeed.nvim',
      "tpope/vim-sleuth",
      "tpope/vim-surround"
    })

    -- TrueZen.nvim is a Neovim plugin that aims to provide a cleaner and less cluttered interface
    -- when toggled in either of it has three different modes (Ataraxis, Minimalist and Focus).
    use({
      "Pocco81/TrueZen.nvim",
      cmd = {
        "TZFocus",
        "TZAtaraxis",
        "TZMinimalist",
      },
      config = function()
        require("plugins/true-zen")
      end,
    })

    -- This plugin adds indentation guides to all lines (including empty lines).
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins/indent-blankline")
      end,
    })

    -- Icons.
    use({
      "kyazdani42/nvim-web-devicons",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.nvim_web_devicons")
      end,
    })

    -- File explorer tree.
    use({
      "kyazdani42/nvim-tree.lua",
      cmd = {
        "NvimTreeOpen",
        "NvimTreeFocus",
        "NvimTreeToggle",
      },
      config = function()
        require("plugins.nvim-tree")
      end,
    })

    -- Bufferline.
    use({
      "akinsho/bufferline.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.bufferline")
      end,
    })

    -- Statusline.
    use({
      "nvim-lualine/lualine.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.lualine.lualine")
      end,
    })

    -- TreeSitter.
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = { "BufRead", "BufNewFile" },
      cmd = {
        "TSInstall",
        "TSInstallInfo",
        "TSInstallSync",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
        "TSDisableAll",
        "TSEnableAll",
      },
      config = function()
        require("plugins.treesitter")
      end,
    })

    -- Colorizer (for highlighting color codes).
    use({
      "norcalli/nvim-colorizer.lua",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins/colorizer")
        vim.cmd("ColorizerAttachToBuffer")
      end,
    })

    -- -- Startup screen.
    -- use({
    --   "goolord/alpha-nvim",
    --   cmd = "Alpha",
    --   config = function()
    --     require("plugins.alpha")
    --   end,
    -- })

    use({
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      cmd = "Telescope",
    })
    use({
      "artart222/telescope_find_directories",
      after = "telescope-fzf-native.nvim",
    })
    use({
      "nvim-telescope/telescope.nvim",
      after = "telescope_find_directories",
      config = function()
        require("plugins.telescope")
      end,
    })

    -- telescope replacement
    use({
      'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function ()
         require("plugins.fzf-lua")
      end
    })

    -- LSP, LSP installer and tab completion.
    use({
      "williamboman/nvim-lsp-installer",
      event = { "BufRead", "BufNewFile" },
      cmd = {
        "LspInstall",
        "LspInstallInfo",
        "LspPrintInstalled",
        "LspRestart",
        "LspStart",
        "LspStop",
        "LspUninstall",
        "LspUninstallAll",
      },
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lsp-installer",
      config = function()
        require("plugins.null_ls")
      end,
    })
    use({
      "neovim/nvim-lspconfig",
      after = "null-ls.nvim",
      config = function()
        require("plugins.lsp.lsp")
      end,
    })

    use({
      "tami5/lspsaga.nvim",
      cmd = "Lspsaga",
    })

    use({
      "simrat39/symbols-outline.nvim",
      cmd = {
        "SymbolsOutline",
        "SymbolsOutlineOpen",
        "SymbolsOutlineClose",
      },
      config = function()
        require("plugins.symbols-outline")
      end,
    })

    use({
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
    })
    use({
      "L3MON4D3/LuaSnip",
      after = "friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    })
    use({
      "hrsh7th/nvim-cmp",
      after = "LuaSnip",
      config = function()
        require("plugins.cmp")
      end,
    })
    use({
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
    })
    use({
      "hrsh7th/cmp-path",
      after = "nvim-cmp",
    })
    use({
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp",
    })
    use({
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
    })
    use({
      "hrsh7th/cmp-nvim-lua",
      ft = "lua",
    })

    -- Github Copilot
    use({
      "github/copilot.vim",
    })

    -- LSP signature.
    use({
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("lsp_signature").setup()
      end,
    })

    -- TODO: Do better lazyloading here for dap.
    use({
      "mfussenegger/nvim-dap",
      event = { "BufRead", "BufNewFile" },
    })
    use({
      "Pocco81/dap-buddy.nvim",
      after = "nvim-dap",
      config = function()
        require("plugins.dap")
      end,
    })
    use({
      "rcarriga/nvim-dap-ui",
      after = "dap-buddy.nvim",
      config = function()
        require("plugins.dapui")
      end,
    })

    -- Terminal.
    use({
      "akinsho/toggleterm.nvim",
      keys = "{ C-t }",
      cmd = "ToggleTerm",
      config = function()
        require("plugins.toggleterm")
      end,
    })

    -- Git support for nvim.
    use({
      "tpope/vim-fugitive",
      cmd = "Git",
    })

    -- Git signs.
    use({
      "lewis6991/gitsigns.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.gitsigns")
      end,
    })

    -- Auto closes.
    use({
      "windwp/nvim-autopairs",
      keys = {
        { "i", "(" },
        { "i", "[" },
        { "i", "{" },
        { "i", "'" },
        { "i", '"' },
        { "i", "<BS>" },
      },
      config = function()
        require("nvim-autopairs").setup()
      end,
    })
    -- This is for html and it can autorename too!
    use({
      "windwp/nvim-ts-autotag",
      ft = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
      },
    })

    -- todo-comments is a lua plugin for Neovim to highlight and search for
    -- todo comments like TODO, HACK, BUG in code base.
    use({
      "folke/todo-comments.nvim",
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("plugins.todo-comments")
      end,
    })

    -- WhichKey is a lua plugin that displays a popup with possible
    -- key bindings of the command you started typing.
    use({
      "folke/which-key.nvim",
      keys = {
        "<leader>",
        "g",
        "d",
        "y",
        "!",
        "z",
        ">",
        "<",
        "]",
        "[",
        "v",
        "c",
      },
      config = function()
        require("plugins/which_key")
      end,
    })

    -- A plugin for neovim that automatically creates missing directories
    -- on saving a file.
    use({
      "jghauser/mkdir.nvim",
      event = { "FileWritePre", "BufWritePre" },
      config = function()
        require("mkdir")
      end,
    })

    -- Neovim plugin to comment in/out text.
    use({
      "b3nj5m1n/kommentary",
      config = function()
        require("plugins.kommentary")
      end,
    })
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
    })

    -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
    use({
      "andymass/vim-matchup",
      event = { "BufRead", "BufNewFile" },
      config = function()
        vim.g.matchup_matchparen_offscreen = {}
      end,
    })

    -- With this plugin you can resize Neovim buffers easily.
    use({
      "artart222/vim-resize",
      event = {
        "FuncUndefined ResizeDown",
        "FuncUndefined ResizeUp",
        "FuncUndefined ResizeLeft",
        "FuncUndefined ResizeRight",
      },
    })


    -- Run :PackerSync if packer.nvim was not installed and
    -- CodeArt installed that.
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    -- Default compile path of packer_compiled file.
    compile_path = fn.stdpath("config") .. "/plugin/" .. "packer_compiled.lua",
    git = {
      clone_timeout = 300,
    },
    -- Adding single border to packer window.
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
