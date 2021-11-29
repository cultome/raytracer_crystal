require "../src/ray_tracer"

include RayTracer

c = canvas(100, 100)
color = color(0.5, 0.7, 0.1)
p = point(0, 1, 0)
hour_translate = Math::PI / 6
factor = 40
offset = 50

12.times do |idx|
  radians = hour_translate * (idx + 1)
  hour = rotation(Axis::Z, radians)
  pt = (hour * p)

  c.write_pixel (pt.x * factor + offset).to_i, (pt.y * factor + offset).to_i, color
end

puts "[*] Generating image..."
File.write "examples/analog_clock.ppm", c.to_ppm
puts "[*] Done!"
