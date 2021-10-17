module RayTracer
  class Matrix
    property data : Array(Array(Float64))

    def initialize(data)
      @data = data.map { |row| row.map(&.to_f) }
    end

    def [](row : Int32, col : Int32)
      data[row][col].to_f
    end

    def ==(mt : Matrix)
      data == mt.data
    end

    def *(mt : Tuple)
      r = data.map do |row|
        row[0] * mt.x +
        row[1] * mt.y +
        row[2] * mt.z +
        row[3] * mt.w
      end

      Tuple.new(r[0], r[1], r[2], r[3])
    end

    def *(mt : Matrix)
      result = data.map do |row|
        row.map_with_index do |_, x|
          row[0] * mt[0, x] +
          row[1] * mt[1, x] +
          row[2] * mt[2, x] +
          row[3] * mt[3, x]
          # multiple dimensions: multiply A row x B column
          #row.map_with_index { |row_val, idx| row_val * mt.data[idx][x].to_f }.sum
        end
      end

      self.class.new result
    end

    def *(scalar : Float64)
      result = data.map do |row|
        row.map { |val| val * scalar }
      end

      self.class.new result
    end

    def /(scalar : Float64)
      self * (1 / scalar)
    end

    def transpose
      result = (0..3).map do |y|
        (0..3).map { |x| data[x][y] }
      end

      self.class.new result
    end

    def determinant
      if data.size > 2
        data[0].map_with_index { |val, idx| val * cofactor(0, idx) }.sum
      else
        data[0][0] * data[1][1] - data[1][0] * data[0][1]
      end
    end

    def submatrix(row, col)
      row_idx = -1

      result = data.select do |_|
        row_idx += 1
        row_idx != row
      end.map do |row|
        col_idx = -1
        row.select do |_|
          col_idx += 1
          col_idx != col
        end
      end

      self.class.new result
    end

    # determinant of the submatrix
    def minor(row, col)
      sub = submatrix row, col
      sub.determinant
    end

    def cofactor(row, col) : Float64
      res_min = minor row, col

      return -res_min if (row + col).odd?
      res_min
    end

    def invertible?
      determinant != 0
    end

    def inverse
      cf_data = (0..3).map do |row|
        [cofactor(row, 0), cofactor(row, 1), cofactor(row, 2), cofactor(row, 3)]
      end

      cfm = self.class.new cf_data
      cfm_t = cfm.transpose

      cfm_t / determinant
    end
  end
end
