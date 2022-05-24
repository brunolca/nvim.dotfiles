lovvcal present, neoscroll_setup = pcall(require, "neoscroll")
if not present then
  return
end

local neoscroll_config = {}

neoscroll_setup.setup(neoscroll_config)
