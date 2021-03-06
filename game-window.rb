class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = "Bulls and Cows"
    SceneManager.set_window(self)
    SceneManager.switch(Scene::Intro)
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
    SceneManager.now.button_down(id) if SceneManager.now.class.instance_methods(false).include?(:button_down)
  end
end