class NumberBall
  attr_accessor :x, :y
  attr_reader   :index

  COLOR_EASYMED = Gosu::Color.argb(0xFF45B649)
  DIAMETER = 16

  def initialize(window, x, y, z, index)
    @window = window
    @@numbers ||= Gosu::Image.new("img/numbers.png")
    @@circle ||= Gosu::Image.new("img/circle16.png")
    @x = x
    @y = y
    @z = z
    @index = index
    @num = @@numbers.subimage(@index * DIAMETER, 0, DIAMETER, DIAMETER)
  end

  def draw
    @@circle.draw(@x, @y, @z, 1, 1, COLOR_EASYMED)
    @num.draw(@x, @y, @z)
  end

  def update
    if under_mouse?
      p @index
    end
  end

  def under_mouse?
    return @window.mouse_x >= @x && @window.mouse_x < @x + DIAMETER && @window.mouse_y >= @y && @window.mouse_y < @y + DIAMETER
  end
end