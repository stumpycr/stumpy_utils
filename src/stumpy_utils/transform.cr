
module StumpyCore
  class Canvas

    def flip_horizontal!
      tmp = Slice(RGBA).new(@width, RGBA.new(0_u16, 0_u16, 0_u16, 0_u16))
      (@height / 2).times do |i|
        r1 = i * @width
        r2 = ((@height - 1 ) - i) * @width

        p1 = @pixels.pointer(@width) + r1
        p2 = @pixels.pointer(@width) + r2

        p1.copy_to(tmp.pointer(@width), @width)
        p2.copy_to(p1, @width)
        tmp.copy_to(p2, @width)
      end
    end

    def flip_vertical!
      @height.times do |i|
        r1 = i * @width

        p1 = @pixels.pointer(@width) + r1

        p1.copy_to(tmp.pointer(@width), @width)
        tmp.reverse!
        tmp.copy_to(p1, @width)
      end
    end

  end

end