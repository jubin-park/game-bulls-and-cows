class Button

	attr_accessor :x, :y
	attr_accessor :width, :height
	attr_writer :caption

	def initialize(window, width, height)
	    @x, @y = 0, 0
	    @width, @height = width, height
	    @caption = ""
	    @gimage_caption = Gosu::Image.from_text("Start", 32)
	end

	def draw(z)
		Gosu.draw_rect(@x, @y, @width, @height, Gosu::Color::GRAY)
		if not (@caption.empty?)
			@gimage_caption.draw(@x + (@width - @gimage_caption.width) / 2, @y + (height - @gimage_caption.height) / 2, z + 1)
		end
	end
end