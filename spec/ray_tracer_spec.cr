require "./spec_helper"

include RayTracer

describe RayTracer do
  it "A tuple with w=1.0 is a point" do
    a = tuple(4.3, -4.2, 3.1, 1.0)
    a.x.should eq 4.3
    a.y.should eq -4.2
    a.z.should eq 3.1
    a.w.should eq 1.0
    a.should be_a Point
    a.should_not be_a Vector
  end

  it "A tuple with w=0 is a vector" do
    a = tuple(4.3, -4.2, 3.1, 0.0)
    a.x.should eq 4.3
    a.y.should eq -4.2
    a.z.should eq 3.1
    a.w.should eq 0.0
    a.should_not be_a Point
    a.should be_a Vector
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
end
