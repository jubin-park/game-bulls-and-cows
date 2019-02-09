# Encoding: UTF-8

require "gosu"
require_relative "button"

WIDTH, HEIGHT = 320, 320

class GameWindow < (Example rescue Gosu::Window)
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
    @button = [Gosu::Image.new("img/button-start0.png"), Gosu::Image.new("img/button-start1.png")]

    @x, @y, @width, @height = 96, 160, 128, 48

    @start_button = Button.new(self, 128, 48, "Start")
    @start_button.x = 96
    @start_button.y = 160
  end

  def draw
    @start_button.draw(0)
    if self.mouse_x >= @x && self.mouse_x < @x + @width && self.mouse_y >= @y && self.mouse_y < @y + @height
      @button[1].draw(96, 160, 1)
    else
      @button[0].draw(96, 160, 1)
    end
  end

  def update
    close if Gosu.button_down?(Gosu::MS_RIGHT)
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      if @start_button.under_mouse?
        p "click"
        @start_button.gimage_caption = nil
        GC.start
      end
    end
  end
end

GameWindow.new.show if __FILE__ == $0
