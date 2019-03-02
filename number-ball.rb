class NumberBall
  attr_accessor :x, :y

  COLOR_EASYMED = Gosu::Color.argb(0xFF45B649)

  def initialize(window, x, y, z, index)
    @window = window
    @@numbers ||= Gosu::Image.new("img/numbers.png")

    @x = x
    @y = y
    @z = z
    @index = index

    @num = @@numbers.subimage(16*@index, 0, 16, 16)
    @circle = Gosu::Image.new("img/circle16.png")
  end

  def draw
    @circle.draw(@x, @y, @z, 1, 1, COLOR_EASYMED)
    @num.draw(@x, @y, @z)
  end

  def update

  end

  def under_mouse?
    return @window.mouse_x >= @x && @window.mouse_x < @x + @width && @window.mouse_y >= @y && @window.mouse_y < @y + @height
  end
end