module RayTracer
  VERSION = "0.1.0"

  alias Numeric = Float64 | Int32

  def point(x, y, z)
    Tuple.new(x, y, z, 1)
  end

  def vector(x, y, z)
    Tuple.new(x, y, z, 0)
  end

  def tuple(x, y, z, w)
    Tuple.new(x, y, z, w)
  end
end

require "./ray_tracer/tuple"
