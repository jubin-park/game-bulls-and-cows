class SceneIntro
  def initialize(window)
    @window = window
    @background = Gosu::Image.new("img/background.png")
    @button_start = Button.new(@window, 128, 48)
    @button_start.x = 96
    @button_start.y = 160
    @button_start.z = 1
    @button_start.set_image(0, Gosu::Image.new("img/button-start0.png"))
    @button_start.set_image(1, Gosu::Image.new("img/button-start1.png"))
    ObjectSpace.define_finalizer(self, self.class.method(:finalize))
  end

  def draw
    @background.draw(0, 0, 0)
    @button_start.draw
  end

  def update
    @button_start.update
  end

  def self.finalize(object_id)
    p "finalizing %d" % object_id
  end
end