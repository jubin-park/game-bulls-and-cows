class Scene
  class Intro
    def initialize(window)
      @window = window
      @background = Gosu::Image.new("img/background.png")
      @logo = Gosu::Image.new("img/logo.png")
      @button_start = Button.new(@window, 128, 48)
      @button_start.x = 96
      @button_start.y = 196
      @button_start.z = 1
      @button_start.set_image(0, Gosu::Image.new("img/button-start0.png"))
      @button_start.set_image(1, Gosu::Image.new("img/button-start1.png"))
      @button_start.set_image(2, Gosu::Image.new("img/button-start2.png"))
      @button_start.set_method(:mouse_down, method(:m_button_start_down))
      @button_start.set_method(:mouse_up, method(:m_button_start_up))
      @scale = 2.0
      @color = Gosu::Color::WHITE.dup
      @color.alpha = 0
    end

    def m_button_start_up
      SceneManager.switch(Scene::Game)
    end

    def m_button_start_down; end

    def draw
      @background.draw(0, 0, 0)
      draw_scaled_logo
      @button_start.draw
    end

    def draw_scaled_logo
      @scale *= 0.95
      @scale = 1.0 if @scale < 1
      @color.alpha += 10
      @color.alpha = 255 if @color.alpha > 255
      @logo.draw_rot(160, 120, 1, 0.0, 0.5, 0.5, @scale, @scale, @color)
    end

    def update
      @button_start.update
    end
  end
end