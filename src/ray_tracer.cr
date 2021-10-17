module RayTracer
  VERSION = "0.1.0"

  alias Numeric = Float64 | Int32

  struct Point
    property x, y, z, w

    def initialize(@x : Numeric, @y : Numeric, @z : Numeric)
      @w = 1
    end
  end

  struct Vector
    property x, y, z, w

    def initialize(@x : Numeric, @y : Numeric, @z : Numeric)
      @w = 0
    end
  end

  def point(x, y, z)
    Point.new(x, y, z)
  end

  def vector(x, y, z)
    Vector.new(x, y, z)
  end

  def tuple(x, y, z, w)
    if w == 0
      vector(x, y, z)
    else
      point(x, y, z)
    end
  end
end
