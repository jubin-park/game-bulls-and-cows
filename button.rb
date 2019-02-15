class Button

	attr_reader		:window
	attr_accessor :x, :y, :width, :height, :z
	attr_writer		:caption
	attr_accessor :gi_caption

	def initialize(window, width, height, caption=nil)
	    @window = window
	    @x, @y = 0, 0
	    @width, @height = width, height
	    @z = 0
	    @caption = caption
	    @image = Array.new(2)
	    if !@caption.nil?
	    	@gi_caption = Gosu::Image.from_text(@caption, height * 0.6)
	    end
	    ObjectSpace.define_finalizer(self, self.class.method(:finalize))
	end

	def set_image(index, gi)
		@image[index] = gi
	end

	def draw
		if !under_mouse?
			@image[0].draw(@x, @y, @z)
		else
			@image[1].draw(@x, @y, @z)
		end
		if !@gi_caption.nil?
			@gi_caption.draw(@x + (@width - @gi_caption.width) / 2, @y + (height - @gi_caption.height) / 2, @z + 1)
		end
	end

	def under_mouse?
		return @window.mouse_x >= @x && @window.mouse_x < @x + @width && @window.mouse_y >= @y && @window.mouse_y < @y + @height
	end

  def self.finalize(object_id)
    p "finalizing %d" % object_id
  end
end