class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
    SceneManager.switch(self, SceneIntro)
  end

  def draw
    SceneManager.now.draw
  end

  def update
    SceneManager.now.update
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