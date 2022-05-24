local present, color = pcall(require, "colorizer")
if not present then
  return
end

local colorizer_config = {
  "*",
  css = { rgb_fn = true },
}

color.setup(colorizer_config)
