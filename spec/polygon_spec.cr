require "./spec_helper"

describe "Polygon" do 

  it "draws polygons" do 
    canvas = Canvas.new(400, 400, RGBA::WHITE)

    # triangle
    canvas.fill_polygon [Point.new(150.0, 50.0), Point.new(250.0, 200.0), Point.new(50.0, 200.0)], RGBA::RED

    # pentagon
    num_points = 5
    radius = 100
    center = Point.new 200.0, 280.0
    points = 0.upto(num_points).map do |n|
      angle = 2.0*Math::PI*n/num_points - Math::PI/2.0
      Point.new Math.cos(angle)*radius + center.x, Math.sin(angle)*radius + center.y
    end.to_a
    canvas.fill_polygon points, RGBA::BLUE
    
    # star
    center = Point.new 280.0, 150.0
    points = 0.upto(num_points*2).map do |n|
      angle = Math::PI*n/num_points - Math::PI/2.0
      r = n % 2 == 0 ? radius : radius/2.0
      Point.new Math.cos(angle)*r + center.x, Math.sin(angle)*r + center.y
    end.to_a
    canvas.fill_polygon points, RGBA::GREEN

    StumpyPNG.write(canvas, "spec/out/polygons.png")
  end

end
