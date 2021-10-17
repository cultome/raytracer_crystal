module RayTracer
  VERSION = "0.1.0"

  alias Numeric = Float64 | Int32

  def point(x, y, z)
    Point.new(x, y, z)
  end

  def vector(x, y, z)
    Vector.new(x, y, z)
  end

  def tuple(x, y, z, w)
    Tuple.new(x, y, z, w)
  end

  def color(r, g, b)
    Color.new(r, g, b)
  end

  def canvas(width, height, color = RayTracer::Color.new(0, 0, 0))
    Canvas.new width, height, color
  end
end

require "./ray_tracer/tuple"
require "./ray_tracer/canvas"
