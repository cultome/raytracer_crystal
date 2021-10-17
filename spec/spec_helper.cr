require "spec"
require "../src/ray_tracer"

def check_matrix_equality(a, b)
  a.data.each_with_index do |row, yidx|
    row.each_with_index do |val, xidx|
      b[yidx, xidx].should be_close(val, 0.0001)
    end
  end
end
