require "../spec_helper"

include RayTracer

describe RayTracer::Tuple do
  it "A tuple with w=1.0 is a point" do
    a = tuple(4.3, -4.2, 3.1, 1.0)
    a.x.should eq 4.3
    a.y.should eq -4.2
    a.z.should eq 3.1
    a.w.should eq 1.0
    a.point?.should be_true
    a.vector?.should_not be_true
  end

  it "A tuple with w=0 is a vector" do
    a = tuple(4.3, -4.2, 3.1, 0.0)
    a.x.should eq 4.3
    a.y.should eq -4.2
    a.z.should eq 3.1
    a.w.should eq 0.0
    a.point?.should_not be_true
    a.vector?.should be_true
  end

  it "point() creates tuples with w=1" do
    p1 = point(4, -4, 3)
    p2 = tuple(4, -4, 3, 1)

    p1.should eq p2
  end

  it "vector() creates tuples with w=0" do
    v1 = vector(4, -4, 3)
    v2 = tuple(4, -4, 3, 0)

    v1.should eq v2
  end

  it "Adding two tuples" do
    a1 = tuple(3, -2, 5, 1)
    a2 = tuple(-2, 3, 1, 0)
    (a1 + a2).should eq tuple(1, 1, 6, 1)
  end

  it "Subtracting two points" do
    p1 = point(3, 2, 1)
    p2 = point(5, 6, 7)
    (p1 - p2).should eq vector(-2, -4, -6)
  end

  it "Subtracting a vector from a point" do
    p = point(3, 2, 1)
    v = vector(5, 6, 7)
    (p - v).should eq point(-2, -4, -6)
  end

  it "Subtracting two vectors" do
    v1 = vector(3, 2, 1)
    v2 = vector(5, 6, 7)
    (v1 - v2).should eq vector(-2, -4, -6)
  end

  it "Subtracting a vector from the zero vector" do
    zero = vector(0, 0, 0)
    v = vector(1, -2, 3)
    (zero - v).should eq vector(-1, 2, -3)
  end

  it "Negating a tuple" do
    a = tuple(1, -2, 3, -4)
    (-a).should eq tuple(-1, 2, -3, 4)
  end

  it "Multiplying a tuple by a scalar" do
    a = tuple(1, -2, 3, -4)
    (a * 3.5).should eq tuple(3.5, -7, 10.5, -14)
  end

  it "Multiplying a tuple by a fraction" do
    a = tuple(1, -2, 3, -4)
    (a * 0.5).should eq tuple(0.5, -1, 1.5, -2)
  end

  it "Dividing a tuple by a scalar" do
    a = tuple(1, -2, 3, -4)
    (a / 2).should eq tuple(0.5, -1, 1.5, -2)
  end

  it "Computing the magnitude of vector(1, 0, 0)" do
    v = vector(1, 0, 0)
    v.magnitude.should eq 1
  end

  it "Computing the magnitude of vector(0, 1, 0)" do
    v = vector(0, 1, 0)
    v.magnitude.should eq 1
  end

  it "Computing the magnitude of vector(0, 0, 1)" do
    v = vector(0, 0, 1)
    v.magnitude.should eq 1
  end

  it "Computing the magnitude of vector(1, 2, 3)" do
    v = vector(1, 2, 3)
    v.magnitude.should eq Math.sqrt(14)
  end

  it "Computing the magnitude of vector(-1, -2, -3)" do
    v = vector(-1, -2, -3)
    v.magnitude.should eq Math.sqrt(14)
  end

  it "Normalizing vector(4, 0, 0) gives (1, 0, 0)" do
    v = vector(4, 0, 0)
    v.normalize.should eq vector(1, 0, 0)
  end

  it "Normalizing vector(1, 2, 3)" do
    v = vector(1, 2, 3) # vector(1/√14, 2/√14, 3/√14)
    norm = v.normalize
    norm.x.should be_close 0.26726, 0.00001
    norm.y.should be_close 0.53452, 0.00001
    norm.z.should be_close 0.80178, 0.00001
  end

  it "The magnitude of a normalized vector" do
    v = vector(1, 2, 3)
    v.normalize.magnitude.should eq 1
  end

  it "The dot product of two tuples" do
    a = vector(1, 2, 3)
    b = vector(2, 3, 4)
    a.dot(b).should eq 20
  end

  it "The cross product of two vectors" do
    a = vector(1, 2, 3)
    b = vector(2, 3, 4)
    a.cross(b).should eq vector(-1, 2, -1)
    b.cross(a).should eq vector(1, -2, 1)
  end

  it "Colors are (red, green, blue) tuples" do
    c = color(-0.5, 0.4, 1.7)
    c.red.should eq -0.5
    c.green.should eq 0.4
    c.blue.should eq 1.7
  end
end
