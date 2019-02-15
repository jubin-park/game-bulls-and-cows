class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
    @scene = SceneIntro.new(self)
  end

  def draw
    @scene.draw
  end

  def update
    @scene.update
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      p "click"
    end
  end
end