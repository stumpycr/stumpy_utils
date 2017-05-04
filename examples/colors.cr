require "stumpy_png"
require "../src/stumpy_utils"
include StumpyPNG

canvas = Canvas.new(200, 200) do |x, y|
  case y
  when 0...50
    RGBA::RED
  when 50...100
    RGBA::YELLOW
  when 100...150
    RGBA::GREEN
  else
    RGBA::BLUE
  end
end

StumpyPNG.write(canvas, "colors.png")
