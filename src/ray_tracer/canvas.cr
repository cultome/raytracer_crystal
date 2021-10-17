module RayTracer
  class Canvas
    property width, height, pixels

    @pixels : Array(Array(RayTracer::Color))

    def initialize(@width : Numeric, @height : Numeric, default_color)
      default_color = RayTracer::Color.new(0, 0, 0) if default_color.nil?

      @pixels = Array.new(height) { Array.new(width) { default_color } }
    end

    def each
      pixels.each_with_index do |row, y|
        row.each_with_index do |pixel, x|
          yield x, y, pixel
        end
      end
    end

    def write_pixel(x : Int32, y : Int32, color : RayTracer::Color)
      pixels[y][x] = color
    end

    def pixel_at(x, y) : RayTracer::Color
      pixels[y][x]
    end

    def to_ppm
      content = IO::Memory.new
      content << "P3\n#{width} #{height}\n255\n"

      pixels.reverse.each do |row|
        line = IO::Memory.new

        row.flat_map(&.to_i).map(&.to_s).each do |color|
          if color.size + line.size > 70
            content << "#{line.to_s.strip}\n"
            line = IO::Memory.new
          end

          line << color + " "
        end

        content << "#{line.to_s.strip}\n"
      end

      content.to_s.chomp
    end
  end
end
