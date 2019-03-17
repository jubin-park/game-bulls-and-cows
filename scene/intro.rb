class Scene
  class Intro
    def initialize(window)
      @window = window
      @background = Gosu::Image.new("img/background.png")
      @button_start = Button.new(@window, 128, 48)
      @button_start.x = 96
      @button_start.y = 160
      @button_start.z = 1
      @button_start.set_image(0, Gosu::Image.new("img/button-start0.png"))
      @button_start.set_image(1, Gosu::Image.new("img/button-start1.png"))
      @button_start.set_image(2, Gosu::Image.new("img/button-start2.png"))
      @button_start.set_method(:mouse_down, method(:m_button_start_down))
      @button_start.set_method(:mouse_up, method(:m_button_start_up))
    end

    def m_button_start_up
      SceneManager.switch(Scene::Game)
    end

    def m_button_start_down; end

    def draw
      @background.draw(0, 0, 0)
      @button_start.draw
    end

    def update
      @button_start.update
    end
  end
end