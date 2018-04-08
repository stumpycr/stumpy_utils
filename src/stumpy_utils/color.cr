module StumpyCore
  struct RGBA
    def mix(other, t)
      RGBA.new(
        (@r * (1.0 - t) + other.r * t).to_u16,
        (@g * (1.0 - t) + other.g * t).to_u16,
        (@b * (1.0 - t) + other.b * t).to_u16,
        (@a * (1.0 - t) + other.a * t).to_u16,
      )
    end
  end
end