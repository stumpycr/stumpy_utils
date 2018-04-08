
module StumpyCore
  class Canvas

    # Xiaolin Wu's circle algorithm
    def circle(center_x, center_y, radius, color = RGBA::BLACK, filled = false)
      radius = radius.to_f
      radius2 = radius * radius

      quater = (radius / Math.sqrt(2)).round.to_i

      # upper & lower
      (0..quater).each do |x|
        y = Math.sqrt(radius2 - x*x)
        plot4(center_x.to_i, center_y.to_i, x, y.to_i, rfpart(y), color)
        plot4(center_x.to_i, center_y.to_i, x, y.to_i + 1, fpart(y), color)

        if filled
          ((center_y.to_i - (y.to_i))..(center_y.to_i + (y.to_i))).each do |y_|
            plot(center_x.to_i + x, y_, 1.0, color)
            plot(center_x.to_i - x, y_, 1.0, color)
          end
        end
      end

      # left & right
      (0..quater).each do |y|
        x = Math.sqrt(radius2 - y*y)
        plot4(center_x.to_i, center_y.to_i, x.to_i, y, rfpart(x), color)
        plot4(center_x.to_i, center_y.to_i, x.to_i+1, y, fpart(x), color)

        if filled
          ((center_x.to_i - (x.to_i))..(center_x.to_i + (x.to_i))).each do |x_|
            plot(x_, center_y.to_i + y, 1.0, color)
            plot(x_, center_y.to_i - y, 1.0, color)
          end
        end
      end
    end

  end

end