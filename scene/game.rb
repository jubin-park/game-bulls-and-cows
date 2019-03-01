class Scene
	class Game
  	def initialize(window)
    	@window = window
    	@background = Gosu::Image.new("img/background.png")
      @hole = Array[Gosu::Image.new "img/hole.png"] * 4
      @numbers = Gosu::Image.new("img/numbers.png")
      @num = Array.new(10) {|index| @numbers.subimage(16*index, 0, 16, 16)}
    end

    def draw
    	@background.draw(0, 0, 0)
      @hole.each_index {|i| @hole[i].draw(88 + i * 36, 64, 1)}
      @num.each_index{|i| @num[i].draw(40 + i * 24, 160, 2)}
    end

    def update
      
    end
  end
end