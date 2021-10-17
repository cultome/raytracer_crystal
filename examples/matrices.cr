require "../src/ray_tracer"

include RayTracer

def pp(t : RayTracer::Tuple)
  puts([t.x, t.y, t.z, t.w].map { |v| v.round(3).to_s.rjust(8) })
end

def pp(m : RayTracer::Matrix)
  m.data.each { |row| puts row.map { |v| v.round(3).to_s.rjust(8) } }
end

a = Matrix.new([
  [-5, 2, 6, -8],
  [1, -5, 1, 8],
  [7, 7, -6, -7],
  [1, -3, 7, 4],
])
b = tuple(1, 2, 3, 1)
id_m = identity_matrix

###############
puts "1. What happens when you invert the identity matrix?"
pp id_m.inverse
###############
puts "2. What do you get when you multiply a matrix by its inverse?"
puts "[*] Can reverse? #{a.invertible?}"
a_inv = a.inverse
pp (a * a_inv)
###############
puts "3. Is there any difference between the inverse of the transpose of a matrix, and the transpose of the inverse?"
puts "[*] Inverse of the transpose"
pp a.transpose.inverse
puts "[*] Transpose of the inverse"
pp a.inverse.transpose
###############
puts "4. Remember how multiplying the identity matrix by a tuple gives you the tuple, unchanged? Now, try changing any single element of the identity matrix to a different number, and then multiplying it by a tuple. What happens to the tuple?"
puts "[*] Before modification"
pp(id_m * b)
puts "[*] After modification"
#id_m.data[0][3] = 1
#id_m.data[0][2] = 1
id_m.data[0][1] = 1
pp (id_m * b)
