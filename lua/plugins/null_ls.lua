local present, null_ls = pcall(require, "null_ls")
if not present then
  return
end

-- Check supported formatters
-- https://git hub.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- Check supported linters
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local null_ls_config = {
  debug = false,
  sources = {
    -- Settings up some linters and code formatters.
    formatting.black,
    formatting.stylua,
    formatting.rustfmt,
    formatting.clang_format,
    formatting.prettier,
    formatting.taplo,
    formatting.shfmt.with({
      command = "shfmt",
      args = {
        "-i",
        "2",
        "-ci",
        "-bn",
        "$FILENAME",
        "-w",
      },
    }),
    diagnostics.zsh,
    -- diagnostics.luacheck,
    diagnostics.pylint,
  },
  on_attach = function(client)
     -- This function is for format on save.
     if client.resolved_capabilities.document_formatting then
       vim.cmd([[
         augroup LspFormatting
             autocmd! * <buffer>
             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
         augroup END
         ]])
     end
   end,
}

null_ls.setup(null_ls_config)

