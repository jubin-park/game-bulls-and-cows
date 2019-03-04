class NumberBall
  attr_accessor :x, :y, :z
  attr_reader   :index

  DIAMETER      = 16
  COLOR_EASYMED = Gosu::Color.argb(0x0045B649)
  
  def initialize(window, x, y, z, index)
    @@numbers ||= Gosu::Image.new("img/numbers.png")
    @@circle  ||= Gosu::Image.new("img/circle16.png")
    @window = window
    @nx = @x = x
    @ny = @y = y
    @z = z
    @index = index
    @num = @@numbers.subimage(@index * DIAMETER, 0, DIAMETER, DIAMETER)
    @color_easymed = COLOR_EASYMED.dup

    @picked = false

    @mouse_sx = @mouse_sy = nil
  end

  def draw
    @@circle.draw(@x, @y, @z, 1, 1, @color_easymed)
    @num.draw(@nx, @ny, @z)
  end

  def update
    if under_mouse?(@x, @y)
      @color_easymed.alpha += 16
    else
      @color_easymed.alpha -= 8
    end
    
    # 집지 않은 상태
    if @picked == false
      # 숫자 영역에 마우스가 올려질 때
      if under_mouse?(@nx, @ny)
        # 마우스를 누를 때
        if Gosu.button_down?(Gosu::MS_LEFT)
          @picked = true
        end
      end
    # 집은 상태
    else
      @nx = @window.mouse_x - DIAMETER / 2
      @ny = @window.mouse_y - DIAMETER / 2
      if Gosu.button_down?(Gosu::MS_LEFT)
        @picked = false
      end
    end
  end

  def under_mouse?(x, y)
    return @window.mouse_x >= x && @window.mouse_x < x + DIAMETER && @window.mouse_y >= y && @window.mouse_y < y + DIAMETER && @@circle[@window.mouse_x-x, @window.mouse_y-y] != "\0\0\0\0"
  end
end