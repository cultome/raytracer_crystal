require "../spec_helper"

include RayTracer

describe RayTracer do
  it "Multiplying by a translation matrix" do
    transform = translation(5, -3, 2)
    p = point(-3, 4, 5)

    (transform * p).should eq point(2, 1, 7)
  end

  it "Multiplying by the inverse of a translation matrix" do
    transform = translation(5, -3, 2)
    inv = transform.inverse
    p = point(-3, 4, 5)

    (inv * p).should eq point(-8, 7, 3)
  end

  it "Translation does not affect vectors" do
    transform = translation(5, -3, 2)
    v = vector(-3, 4, 5)

    (transform * v).should eq v
  end

  it "A scaling matrix applied to a point" do
    transform = scaling(2, 3, 4)
    p = point(-4, 6, 8)

    (transform * p).should eq point(-8, 18, 32)
  end

  it "A scaling matrix applied to a vector" do
    transform = scaling(2, 3, 4)
    v = vector(-4, 6, 8)

    (transform * v).should eq vector(-8, 18, 32)
  end

  it "Multiplying by the inverse of a scaling matrix" do
    transform = scaling(2, 3, 4)
    inv = transform.inverse
    v = vector(-4, 6, 8)

    (inv * v).should eq vector(-2, 2, 2)
  end

  it "Reflection is scaling by a negative value" do
    transform = scaling(-1, 1, 1)
    p = point(2, 3, 4)

    (transform * p).should eq point(-2, 3, 4)
  end

  it "Rotating a point around the x axis" do
    p = point(0, 1, 0)
    half_quarter = rotation(Axis::X, Math::PI / 4)
    full_quarter = rotation(Axis::X, Math::PI / 2)
    half_r = half_quarter * p
    full_r = full_quarter * p

    half_r.x.should be_close 0, 0.00001
    half_r.y.should be_close Math.sqrt(2)/2, 0.00001
    half_r.z.should be_close Math.sqrt(2)/2, 0.00001

    full_r.x.should be_close 0, 0.00001
    full_r.y.should be_close 0, 0.00001
    full_r.z.should be_close 1, 0.00001
  end

  it "The inverse of an x-rotation rotates in the opposite direction" do
    p = point(0, 1, 0)
    half_quarter = rotation(Axis::X, Math::PI / 4)
    inv = half_quarter.inverse
    result = inv * p

    result.x.should be_close 0, 0.00001
    result.y.should be_close Math.sqrt(2)/2, 0.00001
    result.z.should be_close -Math.sqrt(2)/2, 0.00001
  end

  it "Rotating a point around the y axis" do
    p = point(0, 0, 1)
    half_quarter = rotation(Axis::Y, Math::PI / 4)
    full_quarter = rotation(Axis::Y, Math::PI / 2)
    half_r = half_quarter * p
    full_r = full_quarter * p

    half_r.x.should be_close Math.sqrt(2)/2, 0.00001
    half_r.y.should be_close 0, 0.00001
    half_r.z.should be_close Math.sqrt(2)/2, 0.00001

    full_r.x.should be_close 1, 0.00001
    full_r.y.should be_close 0, 0.00001
    full_r.z.should be_close 0, 0.00001
  end

  it "Rotating a point around the z axis" do
    p = point(0, 1, 0)
    half_quarter = rotation(Axis::Z, Math::PI / 4)
    full_quarter = rotation(Axis::Z, Math::PI / 2)
    half_r = half_quarter * p
    full_r = full_quarter * p

    half_r.x.should be_close -Math.sqrt(2)/2, 0.00001
    half_r.y.should be_close Math.sqrt(2)/2, 0.00001
    half_r.z.should be_close 0, 0.00001

    full_r.x.should be_close -1, 0.00001
    full_r.y.should be_close 0, 0.00001
    full_r.z.should be_close 0, 0.00001
  end

  it "A shearing transformation moves x in proportion to y" do
    transform = shearing(1, 0, 0, 0, 0, 0)
    p = point(2, 3, 4)
    result = transform * p

    (transform * p).should eq point(5, 3, 4)
  end

  it "A shearing transformation moves x in proportion to z" do
    transform = shearing(0, 1, 0, 0, 0, 0)
    p = point(2, 3, 4)

    (transform * p).should eq point(6, 3, 4)
  end

  it "A shearing transformation moves y in proportion to x" do
    transform = shearing(0, 0, 1, 0, 0, 0)
    p = point(2, 3, 4)

    (transform * p).should eq point(2, 5, 4)
  end

  it "A shearing transformation moves y in proportion to z" do
    transform = shearing(0, 0, 0, 1, 0, 0)
    p = point(2, 3, 4)

    (transform * p).should eq point(2, 7, 4)
  end

  it "A shearing transformation moves z in proportion to x" do
    transform = shearing(0, 0, 0, 0, 1, 0)
    p = point(2, 3, 4)

    (transform * p).should eq point(2, 3, 6)
  end

  it "A shearing transformation moves z in proportion to y" do
    transform = shearing(0, 0, 0, 0, 0, 1)
    p = point(2, 3, 4)

    (transform * p).should eq point(2, 3, 7)
  end

  it "Individual transformations are applied in sequence" do
    p = point(1, 0, 1)
    a = rotation(Axis::X, Math::PI / 2)
    b = scaling(5, 5, 5)
    c = translation(10, 5, 7)

    # apply rotation first
    p2 = a * p
    p2.x.should be_close 1, 0.00001
    p2.y.should be_close -1, 0.00001
    p2.z.should be_close 0, 0.00001

    # then apply scaling
    p3 = b * p2
    p3.x.should be_close 5, 0.00001
    p3.y.should be_close -5, 0.00001
    p3.z.should be_close 0, 0.00001

    # then apply translation
    p4 = c * p3
    p4.x.should be_close 15, 0.00001
    p4.y.should be_close 0, 0.00001
    p4.z.should be_close 7, 0.00001
  end

  it "Chained transformations must be applied in reverse order" do
    p = point(1, 0, 1)
    a = rotation(Axis::X, Math::PI / 2)
    b = scaling(5, 5, 5)
    c = translation(10, 5, 7)
    t = c * b * a
    (t * p).should eq point(15, 0, 7)
  end
end
