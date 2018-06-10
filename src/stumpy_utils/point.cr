
module StumpyCore
  struct Point
    getter x, y

    def initialize(@x : Float64, @y : Float64)
    end

    def to_s
      "[#{@x},#{@y}]"
    end

    def self.parse(s)
      comps = s.split(",")
      x = comps.first.to_f
      y = comps.second.to_f
      Point.new x, y
    end

    def +(other : Point)
      Point.new(x + other.x, y + other.y)
    end

    def +(other : Float64)
      Point.new(x + other, y + other)
    end

    def -(other)
      Point.new(x - other.x, y - other.y)
    end

    def *(scalar : Float64)
      Point.new(x*scalar, y*scalar)
    end

    def *(other : Point)
      Point.new(x*other.x, y*other.y)
    end

    def /(scalar)
      Point.new(x/scalar, y/scalar)
    end

    def mag
      Math.sqrt(x*x + y*y)
    end

    def normalize
      m = mag
      Point.new(x / m, y / m)
    end

    def self.unit
      Point.new(1.0, 1.0)
    end

    def self.x_unit
      Point.new(1.0, 0.0)
    end

    def self.y_unit
      Point.new(0.0, 1.0)
    end

  end
end