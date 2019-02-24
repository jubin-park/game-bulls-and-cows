module SceneManager
  @@scene = nil
  @@window = nil

  def self.set_window(window)
  	@@window = window
  end

  def self.switch(klass)
    @@scene = nil
    @@scene = klass.new(@@window)
  end

  def self.now
    @@scene
  end
end