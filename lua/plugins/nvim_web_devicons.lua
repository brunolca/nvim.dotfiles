local present, devicons = pcall(require, "nvim-web-devicons")
if not present then
  return
end

local devicons_config = {}

devicons.setup(devicons_config)
