require "./spec_helper"

describe "Mix" do 

  it "mixes colors" do 
    color1 = RGBA::RED
    color2 = RGBA::YELLOW

    canvas = Canvas.new(400, 50) do |x, y|
      color1.mix(color2, x.to_f / 400)
    end

    StumpyPNG.write(canvas, "spec/out/mix.png")
  end
end