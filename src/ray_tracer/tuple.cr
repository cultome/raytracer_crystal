module RayTracer
  class Tuple
    property x, y, z, w

    def initialize(@x : Numeric, @y : Numeric, @z : Numeric, @w : Numeric)
    end

    def vector?
      w == 0
    end

    def point?
      w == 1
    end

    def color?
      w == -1
    end

    def ==(tp : Tuple)
      x == tp.x && y == tp.y && z == tp.z && w == tp.w
    end

    def +(tp : Tuple)
      self.class.new x + tp.x, y + tp.y, z + tp.z, w + tp.w
    end

    def -(tp : Tuple)
      self.class.new x - tp.x, y - tp.y, z - tp.z, w - tp.w
    end

    def -
      self.class.new -x, -y, -z, -w
    end

    def *(scalar : Numeric)
      self.class.new x * scalar, y * scalar, z * scalar, w * scalar
    end

    def /(scalar : Numeric)
      self * (1 / scalar)
    end

    def magnitude
      Math.sqrt(x * x + y * y + z * z + w * w)
    end

    def normalize
      m = 1 / magnitude

      self.class.new x * m, y * m, z * m, w * m
    end

    # scalar_product, inner_product, dot_product
    def dot(tp : Tuple)
      x * tp.x + y * tp.y + z * tp.z + w * tp.w
    end
  end

  class Point < Tuple
    def initialize(x, y, z, w = 1)
      super x, y, z, w
    end
  end

  class Vector < Tuple
    def initialize(x, y, z, w = 0)
      super x, y, z, w
    end

    def cross(tp : Tuple)
      self.class.new(
        y * tp.z - z * tp.y,
        z * tp.x - x * tp.z,
        x * tp.y - y * tp.x,
      )
    end
  end

  class Color < Tuple
    def initialize(r, g, b, w = 0)
      super r, g, b, w
    end

    def red
      x
    end

    def green
      y
    end

    def blue
      z
    end

    def *(c : Color)
      self.class.new x * c.x, y * c.y, z * c.z
    end

    def to_i
      [valid_int(red), valid_int(green), valid_int(blue)]
    end

    private def valid_int(val)
      t = (255 * val).ceil

      t = 255 if t > 255
      t = 0 if t < 0

      t.to_i
    end
  end
end
