# Encoding: UTF-8

require "gosu"
require_relative "game-window"
require_relative "scene-intro"
require_relative "button"

WIDTH, HEIGHT = 320, 320

GameWindow.new.show if __FILE__ == $0