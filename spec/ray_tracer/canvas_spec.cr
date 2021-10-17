require "../spec_helper"

include RayTracer

describe RayTracer::Canvas do
  it "Creating a canvas" do
    c = canvas(10, 20)
    c.width.should eq 10
    c.height.should eq 20

    black = color(0, 0, 0)
    c.each do |x, y, pixel|
      pixel.should eq black
    end
  end

  it "Writing pixels to a canvas" do
    c = canvas(10, 20)
    red = color(1, 0, 0)

    c.write_pixel(2, 3, red)
    c.pixel_at(2, 3).should eq red
  end

  it "Constructing the PPM header" do
    c = canvas(5, 3)
    c.to_ppm.split("\n").first(3).join("|").should eq "P3|5 3|255"
  end

  it "Constructing the PPM pixel data" do
    c = canvas(5, 3)
    c1 = color(1.5, 0, 0)
    c2 = color(0, 0.5, 0)
    c3 = color(-0.5, 0, 1)

    c.write_pixel(0, 0, c1)
    c.write_pixel(2, 1, c2)
    c.write_pixel(4, 2, c3)

    ppm = c.to_ppm
    result = "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0|0 0 0 0 0 0 0 128 0 0 0 0 0 0 0|0 0 0 0 0 0 0 0 0 0 0 0 0 0 255"
    c.to_ppm.split("\n").last(3).join("|").should eq result
  end

  it "Splitting long lines in PPM files" do
    c = canvas(10, 2, color(1, 0.8, 0.6))

    ppm = c.to_ppm
    result = "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204|153 255 204 153 255 204 153 255 204 153 255 204 153|255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204|153 255 204 153 255 204 153 255 204 153 255 204 153"
    c.to_ppm.split("\n")[3...7].join("|").should eq result
  end

  #it "PPM files are terminated by a newline character" do
    #Given c ← canvas(5, 3)
    #When ppm ← canvas_to_ppm(c)
    #Then ppm ends with a newline character
  #end
end
