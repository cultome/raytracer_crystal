require "../src/ray_tracer"

include RayTracer

def tick(env, proj)
  position = proj.position + proj.velocity
  velocity = proj.velocity + env.gravity + env.wind

  Projectile.new(position, velocity)
end

struct Environment
  property gravity, wind

  def initialize(@gravity : RayTracer::Vector, @wind : RayTracer::Vector)
  end
end

struct Projectile
  property position, velocity

  def initialize(@position : RayTracer::Point, @velocity : RayTracer::Vector)
  end

  def y
    position.y
  end

  def x
    position.x
  end
end

# velocity is normalized to 1 unit/tick.
p = Projectile.new(point(0, 1, 0), vector(1, 1, 0).normalize)
# gravity -0.1 unit/tick, and wind is -0.01 unit/tick.
e = Environment.new(vector(0, -0.1, 0), vector(-0.01, 0, 0))

loop do
  puts "(#{p.x}, #{p.y})"

  break if p.y <= 0

  p = tick(e, p)
end
