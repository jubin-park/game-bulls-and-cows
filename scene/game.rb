class Scene
	class Game
  	def initialize(window)
    	@window = window
    	@background = Gosu::Image.new("img/background.png")
      @hole = Array[Gosu::Image.new "img/hole.png"] * 4
      @numbers = Array.new(10)
      10.times {|i| @numbers[i] = Gosu::Image.from_text("#{i}", 24)}
    end

    def draw
    	@background.draw(0, 0, 0)
      @hole.each_index {|i| @hole[i].draw(88 + i * 36, 64, 1)}
      @numbers.each_index{|i| @numbers[i].draw(40 + i * 24, 160, 2)}
    end

    def update
      
    end
  end
end