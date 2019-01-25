class Button

	attr_accessor :x, :y
	attr_accessor :width, :height
	attr_writer :caption
	attr :window

	def initialize(window, width, height, caption="")
	    @window = window
	    @width, @height = width, height
	    @x, @y = 0, 0
	    @caption = caption
	    @gimage_caption = Gosu::Image.from_text(@caption, height * 0.6)
	end

	def under_mouse?
		return @window.mouse_x >= @x && @window.mouse_x < @x + @width && @window.mouse_y >= @y && @window.mouse_y < @y + @height
	end

	def draw(z)
		if under_mouse?
			Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::CYAN)
		else
			Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::GRAY)
		end
		if not (@caption.empty?)
			@gimage_caption.draw(@x + (@width - @gimage_caption.width) / 2, @y + (height - @gimage_caption.height) / 2, z + 1)
		end
	end
end