module SceneManager
	@@scene = nil
	def self.switch(window, klass)
		@@scene = klass.new(window)
	end

	def self.now
		@@scene
	end
end