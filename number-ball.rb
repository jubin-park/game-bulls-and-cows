class NumberBall
  attr_accessor :x, :y, :z
  attr_reader   :index

  DIAMETER      = 16
  COLOR_EASYMED = Gosu::Color.argb(0x0045B649)
  
  def initialize(window, x, y, z, index)
    @@numbers ||= Gosu::Image.new("img/numbers.png")
    @@circle  ||= Gosu::Image.new("img/circle16.png")
    @window = window
    @x = x
    @y = y
    @z = z
    @index = index
    @num = @@numbers.subimage(@index * DIAMETER, 0, DIAMETER, DIAMETER)
    @color_easymed = COLOR_EASYMED.dup
  end

  def draw
    @@circle.draw(@x, @y, @z, 1, 1, @color_easymed)
    @num.draw(@x, @y, @z)
  end

  def update
    if under_mouse?
      @color_easymed.alpha += 16
    else
      @color_easymed.alpha -= 8
    end
  end

  def under_mouse?
    return @window.mouse_x >= @x && @window.mouse_x < @x + DIAMETER && @window.mouse_y >= @y && @window.mouse_y < @y + DIAMETER && @@circle[@window.mouse_x-@x, @window.mouse_y-@y] != "\0\0\0\0"
  end
end