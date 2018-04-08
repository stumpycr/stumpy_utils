
module StumpyCore
  class Canvas

    # Bresenham
    def line_bresenham(x0, y0, x1, y1, color = RGBA::BLACK)
      steep = (y1 - y0).abs > (x1 - x0).abs

      if steep
        x0, y0 = y0, x0
        x1, y1 = y1, x1
      end

      if x0 > x1
        x0, x1 = x1, x0
        y0, y1 = y1, y0
      end

      delta_x = x1 - x0
      delta_y = (y1 - y0).abs

      error = (delta_x / 2).to_i

      ystep = y0 < y1 ? 1 : -1
      y = y0

      ((x0.to_i)...(x1.to_i)).each do |x|
        if steep
          safe_set(y, x, color)
        else
          safe_set(x, y, color)
        end

        error -= delta_y
        if error < 0.0
          y += ystep
          error += delta_x
        end
      end
    end

    # Xiaolin Wu's line algorithm
    def line(x0 : Int, y0 : Int, x1 : Int, y1 : Int, color = RGBA::BLACK)
      line(x0.to_f, y0.to_f, x1.to_f, y1.to_f, color)
    end

    def line(x0, y0, x1, y1, color = RGBA::BLACK)
      steep = (y1 - y0).abs > (x1 - x0).abs

      if steep
        x0, y0 = y0, x0
        x1, y1 = y1, x1
      end

      if x0 > x1
        x0, x1 = x1, x0
        y0, y1 = y1, y0
      end

      delta_x = x1 - x0
      delta_y = y1 - y0

      gradient = delta_x == 0.0 ? 1.0 : delta_y / delta_x

      # first endpoint
      xend = x0.round.to_i
      yend = y0 + gradient * (xend - x0)

      xgap = rfpart(x0 + 0.5)

      xpxl1 = xend
      ypxl1 = yend.to_i

      if steep
        plot(ypxl1, xpxl1,  rfpart(yend) * xgap, color)
        plot(ypxl1+1, xpxl1, fpart(yend) * xgap, color)
      else
        plot(xpxl1, ypxl1,  rfpart(yend) * xgap, color)
        plot(xpxl1, ypxl1+1, fpart(yend) * xgap, color)
      end

      intery = yend + gradient

      # second endpoint
      xend = x1.round.to_i
      yend = y1 + gradient * (xend - x1)

      xgap = fpart(x1 + 0.5)

      xpxl2 = xend
      ypxl2 = yend.to_i

      if steep
        plot(ypxl2, xpxl2, rfpart(yend) * xgap, color)
        plot(ypxl2+1, xpxl2, fpart(yend) * xgap, color)
      else
        plot(xpxl2, ypxl2, rfpart(yend) * xgap, color)
        plot(xpxl2, ypxl2+1, fpart(yend) * xgap, color)
      end

      # main loop

      if steep
        ((xpxl1 + 1)..(xpxl2 -1)).each do |x|
          plot(intery.to_i, x, rfpart(intery), color)
          plot(intery.to_i + 1, x, fpart(intery), color)

          intery = intery + gradient
        end
      else
        ((xpxl1 + 1)..(xpxl2 -1)).each do |x|
          plot(x, intery.to_i, rfpart(intery), color)
          plot(x, intery.to_i + 1, fpart(intery), color)

          intery = intery + gradient
        end
      end
    end

    private def plot(x : Int32, y : Int32, c, color)
      if includes_pixel?(x, y)
        transparent = RGBA.new(color.r, color.g, color.b, (color.a * c).to_u16)
        real_color = transparent.over(get(x, y))
        set(x, y, real_color)
      end
    end

    private def plot4(x, y, delta_x, delta_y, c, color)
      plot(x + delta_x, y + delta_y, c, color)
      plot(x - delta_x, y + delta_y, c, color)

      plot(x + delta_x, y - delta_y, c, color)
      plot(x - delta_x, y - delta_y, c, color)
    end

    private def fpart(x)
      x < 0 ? (1.0 - (x - x.floor)) : (x - x.floor)
    end

    private def rfpart(x)
      1.0 - fpart(x)
    end

  end

end