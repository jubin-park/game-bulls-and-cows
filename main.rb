# Encoding: UTF-8

require "gosu"
require_relative "game-window"
require_relative "scene-manager"
require_relative "button"
require_relative "number-ball"

require_relative "scene/intro"
require_relative "scene/game"

WIDTH, HEIGHT = 320, 320

GameWindow.new.show if __FILE__ == $0