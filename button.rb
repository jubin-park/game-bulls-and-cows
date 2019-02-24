class Button
  attr_reader   :window
  attr_accessor :x, :y, :width, :height, :z
  attr_writer   :caption
  attr_accessor :gi_caption

  def initialize(window, width, height, caption=nil)
    @window = window
    @x, @y = 0, 0
    @width, @height = width, height
    @z = 0
    @caption = caption
    @image = Array.new(2)
    if !@caption.nil?
      @gi_caption = Gosu::Image.from_text(@caption, height * 0.6)
    end
    @area = :out
    @mouse = :up
    @event_method = Hash.new
  end

  def set_image(index, gi)
    @image[index] = gi
  end

  def draw
    if !under_mouse?
      @image[0].draw(@x, @y, @z)
    else
      @image[1].draw(@x, @y, @z)
    end
    if !@gi_caption.nil?
      @gi_caption.draw(@x + (@width - @gi_caption.width) / 2, @y + (height - @gi_caption.height) / 2, @z + 1)
    end
  end

  def update
    if under_mouse?
      if Gosu.button_down?(Gosu::MS_LEFT)
        if @area == :in
          if @mouse == :up
            #p "down"
            @event_method[:mouse_down].call if @event_method[:mouse_down].is_a?(Method)
            @mouse = :down
          end
        end
      else
        @area = :in
        if @mouse == :down
          #p "up"
          @event_method[:mouse_up].call if @event_method[:mouse_down].is_a?(Method)
          @mouse = :up
        end
      end
    else
      @area = :out
      if Gosu.button_down?(Gosu::MS_LEFT)
        if @mouse == :down
          #p "!"
        end
      else
        @mouse = :up
      end
    end
  end

  def under_mouse?
    return @window.mouse_x >= @x && @window.mouse_x < @x + @width && @window.mouse_y >= @y && @window.mouse_y < @y + @height
  end

  def set_method(type, mtd)
    @event_method[type] = mtd
  end
end