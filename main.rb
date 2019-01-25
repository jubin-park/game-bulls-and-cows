# Encoding: UTF-8

require "gosu"
require_relative "button"

WIDTH, HEIGHT = 320, 320

class GameWindow < (Example rescue Gosu::Window)
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
    @start_button = Button.new(self, 128, 48)
    @start_button.x = 96
    @start_button.y = 160
    @start_button.caption = "Start"
  end

  def draw
    @start_button.draw(0)
  end

  def update
    close if Gosu.button_down?(Gosu::MS_RIGHT)
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      p "!" if @start_button.under_mouse?
    end
  end
end

GameWindow.new.show if __FILE__ == $0
