class Scene
	class Game
  	def initialize(window)
    	@window = window
    	@background = Gosu::Image.new("img/background.png")
      @hole = Array[Gosu::Image.new "img/hole.png"] * 4
      @numbers = Gosu::Image.new("img/numbers.png")
      @num = Array.new(10) {|index| @numbers.subimage(16*index, 0, 16, 16)}
      @circle = Array.new(10) {|index| Gosu::Image.new("img/circle16.png")}
    end

    def draw
    	@background.draw(0, 0, 0)
      @hole.each_index {|i| @hole[i].draw(88 + i * 36, 64, 1)}
      @circle.each_index{|i| @circle[i].draw(40 + i * 24, 160, 2, 1, 1, Gosu::Color.argb(0xFF45B649))}
      @num.each_index{|i| @num[i].draw(40 + i * 24, 160, 3)}
    end

    def update
      
    end
  end
end