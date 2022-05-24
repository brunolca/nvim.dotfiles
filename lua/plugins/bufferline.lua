local present, bufferline_setup = pcall(require, "bufferline")
if not present then
  return
end

local bufferline_config = {
  options = {
    numbers = function(opts)
      return string.format("%s", opts.id)
    end,
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "vista_kind",
        text = "Lsp Tags",
        text_align = "center",
      },
      {
        filetype = "Outline",
        text = " Lsp Tags",
        text_align = "center",
      },
    },
  },
}

bufferline_setup.setup(bufferline_config)
