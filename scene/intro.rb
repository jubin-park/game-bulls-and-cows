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
      @button_start.set_method(:mouse_down, method(:button_down))
      @button_start.set_method(:mouse_up, method(:button_up))
    end

    def button_up
      SceneManager.switch(Scene::Game)
    end

    def button_down
      @a ||= 100
    end

    def draw
      @background.draw(0, 0, 0)
      @button_start.draw
    end

    def update
      @button_start.update
    end
  end
end