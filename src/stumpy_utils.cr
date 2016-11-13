module StumpyUtils
  # Bresenham line drawing algorithm
  def self.line(canvas, x0, y0, x1, y1, color)
    steep = (y1 - y0).abs > (x1 - x0).abs

    if steep
      x0, y0 = {y0, x0}
      x1, y1 = {y1, x1}
    end

    if x0 > x1
      x0, x1 = {x1, x0}
      y0, y1 = {y1, y0}
    end

    delta_x = x1 - x0
    delta_y = (y1 - y0).abs

    error = (delta_x / 2).to_i

    ystep = y0 < y1 ? 1 : -1
    y = y0

    ((x0.to_i)...(x1.to_i)).each do |x|
      if steep
        canvas.safe_set(y, x, color)
      else
        canvas.safe_set(x, y, color)
      end

      error -= delta_y
      if error < 0.0
        y += ystep
        error += delta_x
      end
    end
  end
end
