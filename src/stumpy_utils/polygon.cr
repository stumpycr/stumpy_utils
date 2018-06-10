
module StumpyCore
  class EdgeBucket
    getter y_max : Int32, y_min : Int32
    property x : Int32
    getter slope : Int32
    getter delta_x : Int32, delta_y : Int32
    property sum : Int32
  
    def initialize(@y_max, @y_min, @x, @slope, @delta_x, @delta_y, @sum = 0)
    end
  
    def self.from_vertices(v1, v2) : EdgeBucket
      # The vertices need to be ordered from left to right
      if v1.x > v2.x
        tmp = v1
        v1 = v2
        v2 = tmp
      end
  
      if v1.y > v2.y
        y_max, y_min, x, slope = {v1.y, v2.y, v2.x, -1}
      else
        y_max, y_min, x, slope = {v2.y, v1.y, v1.x,  1}
      end
  
      delta_x = (v1.x - v2.x).abs
      delta_y = (v1.y - v2.y).abs
  
      self.new(
        y_max.to_i32, y_min.to_i32,
        x.to_i32,
        slope,
        delta_x.to_i32, delta_y.to_i32
      )
    end
  end


  class Canvas

    def fill_polygon(vertices, color = RGBA::BLACK)
      edges = vertices.each_cons(2).to_a + [[vertices[0], vertices[-1]]]
      edge_table = edges.map { |vs| EdgeBucket.from_vertices(vs[0], vs[1]).as(EdgeBucket) }
      edge_table.sort_by!(&.y_min)
      edge_table.reject! { |e| e.delta_y == 0 }

      scanline = edge_table[0].y_min
      active_list = [] of EdgeBucket

      until edge_table.empty?
        # Remove edges that are no longer active (=> out of range)
        unless active_list.empty?
          active_list.reject! { |eb| eb.y_max == scanline }
          edge_table.reject! { |eb| eb.y_max == scanline }
        end

        # Add edges that are now in range
        active_list += edge_table.select { |e| e.y_min == scanline }

        # Sort by x and slope
        active_list.sort! do |e1, e2|
          v1 = e1.x - e2.x
          next v1 unless v1 == 0
          (e1.delta_x / e1.delta_y) - (e2.delta_x / e2.delta_y)
        end

        # Fill pixels
        active_list.each_slice(2) do |es|
          e1 = es[0]
          if es.size == 1
            if self.includes_pixel?(e1.x, scanline)
              self[e1.x, scanline] = color
            end
            next
          end
          e2 = es[1]
          (e1.x..e2.x).each do |x|
            y = scanline
            if self.includes_pixel?(x, y)
              self[x, y] = color
            end
          end
        end

        scanline += 1

        # Increment all x variables based on the slope
        active_list.each do |edge|
          if edge.delta_x != 0
            edge.sum += edge.delta_x

            while edge.sum >= edge.delta_y
              edge.x += edge.slope
              edge.sum -= edge.delta_y
            end
          end
        end
      end
    end

  end
end
