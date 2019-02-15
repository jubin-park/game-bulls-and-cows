class SceneIntro
	def initialize(window)
		@window = window
		@background = Gosu::Image.new("img/background.png")
		@button = [Gosu::Image.new("img/button-start0.png"), Gosu::Image.new("img/button-start1.png")]
		@x, @y, @width, @height = 96, 160, 128, 48
		#@start_button = Button.new(@window, 128, 48, "Start")
		#@start_button.x = 96
		#@start_button.y = 160
		
	end

	def draw
		@background.draw(0, 0, 0)
	    if @window.mouse_x >= @x && @window.mouse_x < @x + @width && @window.mouse_y >= @y && @window.mouse_y < @y + @height
	      @button[1].draw(96, 160, 1)
	    else
	      @button[0].draw(96, 160, 1)
	    end
	end

	def update
		close if Gosu.button_down?(Gosu::MS_RIGHT)
	end
end