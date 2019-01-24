# Encoding: UTF-8

require "gosu"

WIDTH, HEIGHT = 320, 320

class GameWindow < (Example rescue Gosu::Window)
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
  end
  
  def draw
  end

  def update
    close if Gosu.button_down? Gosu::MS_RIGHT
  end

  def needs_cursor?
    true
  end

  def button_down(id)
  end

end

GameWindow.new.show if __FILE__ == $0
