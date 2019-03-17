class Scene
  class Game
    module ZOrder
      BACKGROUND = 0
      HOLE = 1
      NUMBER = 2
      BUTTON_HIT = 3
      LOG_BOX = 4
    end

    DIGITS = 4
    LOG_MAX_SIZE = 10
    LOG_HEIGHT = 24
    RECT_LOG = [24, 168, 272, 128]
    PADDING = 4

    IMAGE_BULL = Gosu::Image.new("img/bull.png")
    IMAGE_COW = Gosu::Image.new("img/cow.png")

    def initialize(window)
      @window = window
      @background = Gosu::Image.new("img/background.png")
      @holes = Array[Gosu::Image.new "img/hole.png"] * DIGITS
      @balls = Array.new(10) {|i| NumberBall.new(window, locate_init_x(i), locate_init_y, ZOrder::NUMBER, i)}
      @balls.each do |ball|
        ball.set_method(:pick_up, method(:m_ball_pickup))
        ball.set_method(:pick_down, method(:m_ball_pickdown))
      end
      @button_hit = Button.new(@window, 32, 32)
      @button_hit.x = @window.width / 2 - 16
      @button_hit.y = 128
      @button_hit.z = ZOrder::BUTTON_HIT
      @button_hit.set_image(0, Gosu::Image.new("img/button-hit.png"))
      @button_hit.set_image(1, Gosu::Image.new("img/button-hit.png"))
      @button_hit.set_method(:mouse_down, method(:m_hit_down))
      @button_hit.set_method(:mouse_up, method(:m_hit_up))
      @container_log = Gosu::Image.new(EmptyImageSource.new(RECT_LOG[2], LOG_MAX_SIZE * LOG_HEIGHT, Gosu::Color::NONE))
      @viewport_log = @container_log.subimage(0, 0, RECT_LOG[2] - PADDING * 2, RECT_LOG[3] - PADDING * 2)
      p @rand_numbers = generate_random_number(DIGITS)
      @your_numbers = Array.new(DIGITS)
      @your_numbers = [1, 2, 3, 4]
      @log_y = 0
      @scroll_y = 0
      @queue_log = []
    end

    def draw
      @background.draw(0, 0, ZOrder::BACKGROUND)
      @holes.each_index {|i| @holes[i].draw(locate_hole_x(i), locate_hole_y, ZOrder::HOLE)}
      @balls.each{|ball| ball.draw}
      @button_hit.draw
      # draw log
      Gosu.draw_rect(*RECT_LOG, Gosu::Color.argb(128, 0, 0, 0), ZOrder::LOG_BOX)
      @viewport_log.draw(RECT_LOG[0] + PADDING, RECT_LOG[1] + PADDING, ZOrder::LOG_BOX)
    end

    def update
      @balls.each{|ball| ball.update}
      @button_hit.update
    end

    def button_down(id)
      case id
      when Gosu::MS_WHEEL_DOWN
        if @log_y > @viewport_log.height
          @scroll_y += LOG_HEIGHT
          @scroll_y = @container_log.height - RECT_LOG[3] + PADDING * 2 if @scroll_y >= @container_log.height - RECT_LOG[3] + PADDING * 2
          @viewport_log = @container_log.subimage(0, @scroll_y, RECT_LOG[2] - PADDING * 2, RECT_LOG[3] - PADDING * 2)
        end
      when Gosu::MS_WHEEL_UP
        @scroll_y -= LOG_HEIGHT
        @scroll_y = 0 if @scroll_y < 0
        @viewport_log = @container_log.subimage(0, @scroll_y, RECT_LOG[2] - PADDING * 2, RECT_LOG[3] - PADDING * 2)
      end
    end

    def add_log(bull, cow)
      log = Gosu::Image.new(EmptyImageSource.new(RECT_LOG[2] - PADDING * 2, LOG_HEIGHT, Gosu::Color.argb(128, rand(255), rand(255), rand(255))))#Gosu::Color::NONE))
      for i in 0...DIGITS
        number = @balls[@your_numbers[i]].num
        log.insert(number, 8 + i * 16, 4)
      end
      x = log.width
      for c in 0...cow
        x -= 24
        log.insert(IMAGE_COW, x, 0)
      end
      for b in 0...bull
        x -= 24
        log.insert(IMAGE_BULL, x, 0)
      end
      @queue_log.push(log)
      if @queue_log.size > LOG_MAX_SIZE
        @queue_log.shift
        # rearrange
        @queue_log.each_index {|i| @container_log.insert(@queue_log[i], 0, i * LOG_HEIGHT)}
      else
        @container_log.insert(log, 0, @log_y)
        @log_y += LOG_HEIGHT
      end
      if @queue_log.size > 5
        @scroll_y = LOG_HEIGHT * (@queue_log.size - 5)
        @viewport_log = @container_log.subimage(0, @scroll_y, RECT_LOG[2] - PADDING * 2, RECT_LOG[3] - PADDING * 2)
      end
    end

    def locate_init_x(index)
      40 + index * 24
    end

    def locate_init_y
      100
    end

    def locate_hole_x(index)
      (@window.width - DIGITS * 36) / 2 + index * 36
    end

    def locate_hole_y
      40
    end

    def m_hit_down
      @button_hit.y += 1
    end

    def m_hit_up
      @button_hit.y -= 1
      bull = cow = 0
      for i in 0...DIGITS
        if @your_numbers[i] == nil
          p "Please fill the all numbers"
          return
        end
        if @rand_numbers[i] == @your_numbers[i]
          bull += 1
        else
          if @rand_numbers.include?(@your_numbers[i])
            cow += 1
          end
        end
      end
      add_log(bull, cow)
    end

    def m_ball_pickup(number)
      target_hole = (@window.mouse_x.to_i - locate_hole_x(0)) / 36
      # cursor in the hole
      if @window.mouse_y >= 40 && @window.mouse_y < 72 && target_hole >= 0 && target_hole < DIGITS
        # select number in the hole
        if @balls[number].in_hole == true
          # pop number
          @balls[number].in_hole = false
          @your_numbers[target_hole] = nil
          @last_pop ||= target_hole
        end
      end
    end

    def m_ball_pickdown(number)
      target_hole = (@window.mouse_x.to_i - locate_hole_x(0)) / 36
      # cursor in the hole
      if @window.mouse_y >= 40 && @window.mouse_y < 72 && target_hole >= 0 && target_hole < DIGITS
        prev_number = @your_numbers[target_hole]
        # number has already been
        if prev_number.is_a?(Integer)
          if @last_pop.is_a?(Integer)
            # swap
            @balls[prev_number].in_hole = true
            @balls[prev_number].nx = locate_hole_x(@last_pop) + 8
            @balls[prev_number].ny = locate_hole_y + 8
            @your_numbers[@last_pop] = prev_number
            @last_pop = nil
          else
            # original position
            @balls[prev_number].in_hole = false
            @balls[prev_number].nx = locate_init_x(prev_number)
            @balls[prev_number].ny = locate_init_y
          end
        end
        @balls[number].in_hole = true
        @balls[number].nx = locate_hole_x(target_hole) + 8
        @balls[number].ny = locate_hole_y + 8
        @your_numbers[target_hole] = number
      else
        @balls[number].in_hole = false
        @balls[number].nx = locate_init_x(number)
        @balls[number].ny = locate_init_y
        @last_pop = nil
      end
    end

    def generate_random_number(digit)
      arr = Array.new
      list = *(0..9)
      while arr.size < digit
        idx = rand(list.size)
        arr.push(list[idx])
        list.delete_at(idx)
      end
      return arr
    end
  end
end