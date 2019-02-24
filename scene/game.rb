class Scene
	class Game
  	def initialize(window)
    	@window = window
    	@background = Gosu::Image.new("img/background.png")
    end

    def draw
    	@background.draw(0, 0, 0)
    end

    def update

    end
  end
end