require "./spec_helper"

describe "Circle" do 

  it "draws circles" do 
    canvas = Canvas.new(400, 400, RGBA::WHITE)
    colors = [RGBA::WHITE, RGBA::DARKSLATEGRAY, RGBA::LIGHTBLUE, RGBA::RED, RGBA::YELLOW]

    colors.each_with_index do |color, i|
      radius = (colors.size - i) * 40
      canvas.circle(200, 200, radius, color, true)
    end

    (colors.size * 2).times do |i|
      radius = ((colors.size * 2) - i) * 20
      canvas.circle(200, 200, radius, RGBA::BLACK, false)
    end

    StumpyPNG.write(canvas, "spec/out/circles.png")
  end
end
