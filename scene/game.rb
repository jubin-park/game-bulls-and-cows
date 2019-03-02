class Scene
	class Game
    
  	def initialize(window)
    	@window = window
    	@background = Gosu::Image.new("img/background.png")
      @hole = Array[Gosu::Image.new "img/hole.png"] * 4
      @number_ball = Array.new(10) {|i| NumberBall.new(window, 40 + i * 24, 100, 3, i)}
    end

    def draw
    	@background.draw(0, 0, 0)
      @hole.each_index {|i| @hole[i].draw(88 + i * 36, 40, 1)}
      @number_ball.each{|ball| ball.draw}
      Gosu.draw_rect(24, 176, 272, 120, Gosu::Color.argb(128, 0, 0, 0), 0)
    end

    def update
      @number_ball.each{|ball| ball.update}
    end
  end
end