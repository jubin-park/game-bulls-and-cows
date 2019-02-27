class Scene
	class Game
  	def initialize(window)
    	@window = window
    	@background = Gosu::Image.new("img/background.png")
        @hole = Array[Gosu::Image.new "img/hole.png"] * 4
    end

    def draw
    	@background.draw(0, 0, 0)
        @hole.each_index {|i| @hole[i].draw(88 + i * 36, 64, 1)}
    end

    def update
        
    end
  end
end