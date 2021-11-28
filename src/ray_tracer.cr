module RayTracer
  VERSION = "0.1.0"

  alias Numeric = Float64 | Int32
  enum Axis
    X
    Y
    Z
  end

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

  def identity_matrix
    Matrix.new([
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
    ])
  end

  def translation(x : Numeric, y : Numeric, z : Numeric) : RayTracer::Matrix
    Matrix.new([
      [1, 0, 0, x],
      [0, 1, 0, y],
      [0, 0, 1, z],
      [0, 0, 0, 1],
    ])
  end

  def scaling(x : Numeric, y : Numeric, z : Numeric) : RayTracer::Matrix
    Matrix.new([
      [x, 0, 0, 0],
      [0, y, 0, 0],
      [0, 0, z, 0],
      [0, 0, 0, 1],
    ])
  end

  def rotation(axis : Axis, radians : Numeric) : RayTracer::Matrix
    case axis
    when Axis::X
      Matrix.new([
        [1, 0,                 0,                  0],
        [0, Math.cos(radians), -Math.sin(radians), 0],
        [0, Math.sin(radians), Math.cos(radians),  0],
        [0, 0,                 0,                  1],
      ])
    when Axis::Y
      Matrix.new([
        [Math.cos(radians),  0, Math.sin(radians), 0],
        [0,                  1, 0,                 0],
        [-Math.sin(radians), 0, Math.cos(radians), 0],
        [0,                  0, 0,                 1],
      ])
    when Axis::Z
      Matrix.new([
        [Math.cos(radians), -Math.sin(radians), 0, 0],
        [Math.sin(radians), Math.cos(radians),  0, 0],
        [0,                 0,                  1, 0],
        [0,                 0,                  0, 1],
      ])
    else
      raise "Invalid axis #{axis}"
    end
  end
end

require "./ray_tracer/tuple"
require "./ray_tracer/matrix"
require "./ray_tracer/canvas"
