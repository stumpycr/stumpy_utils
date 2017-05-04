require "stumpy_png"
require "../src/stumpy_utils"
include StumpyPNG

color1 = RGBA::RED
color2 = RGBA::YELLOW

canvas = Canvas.new(400, 50) do |x, y|
  color1.mix(color2, x.to_f / 400)
end

StumpyPNG.write(canvas, "mix.png")
