# Encoding: UTF-8

require "gosu"

WIDTH, HEIGHT = 320, 320

class GameWindow < (Example rescue Gosu::Window)
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
    @message = Gosu::Image.from_text("Start", 32)
  end
  
  def draw
    Gosu.draw_rect(96, 160, 128, 48, Gosu::Color::GRAY)
    @message.draw(96+128/2-@message.width/2, 168, 1)
  end

  def update
    close if Gosu.button_down? Gosu::MS_RIGHT
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      p "click!"
    end
  end

end

GameWindow.new.show if __FILE__ == $0
