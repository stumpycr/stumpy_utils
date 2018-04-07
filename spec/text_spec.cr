require "./spec_helper"

describe "Text" do 

  it "draws text" do 
    canvas = Canvas.new(500, 80, RGBA::WHITE)

    font1 = PCFParser::Font.from_file("./fonts/10x20.pcf")
    font2 = PCFParser::Font.from_file("./fonts/helvR18.pcf")

    text = "The quick brown fox jumps over the lazy dog"

    canvas.text(10, 30, text, font1)
    canvas.text(10, 60, text, font2, RGBA::BLUE)

    StumpyPNG.write(canvas, "spec/out/text.png")
  end
end