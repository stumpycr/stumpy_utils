require "pcf-parser"

module StumpyCore
  class Canvas

    def text(x, y, string, font, color = RGBA::BLACK)
      font.lookup(string).each do |c|
        (0...c.width).each do |x_|
          (0...(c.ascent + c.descent)).each do |y_|
            real_x = x + x_ + c.left_sided_bearing
            real_y = y + y_ - c.ascent
            safe_set(real_x, real_y, color) if c.get(x_, y_)
          end
        end

        # TODO: This looks strange for chars like ',',
        # but incrementing by c.left_sided_bearing + c.right_sided_bearing
        # looks strange for some fonts
        x += c.width
      end
    end
  end

end
