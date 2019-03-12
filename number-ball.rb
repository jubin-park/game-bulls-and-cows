class NumberBall
  attr_accessor :x, :y, :z
  attr_accessor :nx, :ny
  attr_reader   :index
  attr_accessor :picked, :in_hole

  DIAMETER      = 16
  COLOR_EASYMED = Gosu::Color.argb(0x0045B649)
  
  def initialize(window, x, y, z, index)
    @window = window
    @nx = @x = x
    @ny = @y = y
    @z = z
    @index = index
    @picked = false
    @in_hole = false

    @@numbers ||= Gosu::Image.new("img/numbers.png")
    @@circle  ||= Gosu::Image.new("img/circle16.png")
    @num = @@numbers.subimage(@index * DIAMETER, 0, DIAMETER, DIAMETER)
    @color_easymed = COLOR_EASYMED.dup
    
    @mouse = :up
    @event_method = Hash.new
  end

  def draw
    @@circle.draw(@x, @y, @z, 1, 1, @color_easymed)
    @num.draw(@nx, @ny, @z)
  end

  def update
    if under_mouse?(@x, @y, DIAMETER, DIAMETER)
      if !@picked && !@in_hole
        @color_easymed.alpha += 16
      else
        @color_easymed.alpha -= 8
      end
    else
      @color_easymed.alpha -= 8
    end
    if Gosu.button_down?(Gosu::MS_LEFT)
      # 집을 때
      if @picked == false
        if under_mouse?(@nx, @ny, DIAMETER, DIAMETER)
          if @mouse == :up
            @mouse = :down
            @picked = true
            @event_method[:pick_up].call(@index) if @event_method[:pick_up].is_a?(Method)
          end
        end
      # 놓을 때
      else
        if @mouse == :up
          @mouse = :down
          @picked = false
          @event_method[:pick_down].call(@index) if @event_method[:pick_down].is_a?(Method)
        end
      end
    else
      if @mouse == :down
        @mouse = :up
        #p "up"
      end
    end
    if @picked == true && @in_hole == false
      @nx = @window.mouse_x.to_i - DIAMETER / 2
      @ny = @window.mouse_y.to_i - DIAMETER / 2
    end
  end

  def under_mouse?(x, y, w, h)
    return @window.mouse_x >= x && @window.mouse_x < x + w && 
            @window.mouse_y >= y && @window.mouse_y < y + h &&
            @@circle[@window.mouse_x-x, @window.mouse_y-y] != "\0\0\0\0"
  end

  def set_method(type, mtd)
    @event_method[type] = mtd
  end

end