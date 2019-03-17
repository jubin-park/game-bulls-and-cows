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
    RECT_LOG = [24, 168, 272, 128]
    IMAGE_BULL = Gosu::Image.new("img/bull.png")
    IMAGE_COW = Gosu::Image.new("img/cow.png")

    def initialize(window)
      @window = window
      @background = Gosu::Image.new("img/background.png")
      @holes = Array[Gosu::Image.new "img/hole.png"] * DIGITS
      @balls = Array.new(10) {|i| NumberBall.new(window, 40 + i * 24, 100, ZOrder::NUMBER, i)}
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
      @image_log = Gosu::Image.new(EmptyImageSource.new(RECT_LOG[2], RECT_LOG[3], Gosu::Color::NONE))
      p @rand_numbers = generate_random_number(DIGITS)
      @your_numbers = Array.new(DIGITS)
      @your_numbers = [1, 2, 3, 4]
      @log_y = 0
    end

    def draw
      @background.draw(0, 0, ZOrder::BACKGROUND)
      @holes.each_index {|i| @holes[i].draw(88 + i * 36, 40, ZOrder::HOLE)}
      @balls.each{|ball| ball.draw}
      @button_hit.draw
      # draw log
      Gosu.draw_rect(*RECT_LOG, Gosu::Color.argb(128, 0, 0, 0), ZOrder::LOG_BOX)
      @image_log.draw(RECT_LOG[0], RECT_LOG[1], ZOrder::LOG_BOX)
    end

    def update
      @balls.each{|ball| ball.update}
      @button_hit.update
    end

    def add_log(bull, cow)
      for i in 0...DIGITS
        number = @balls[@your_numbers[i]].num
        @image_log.insert(number, 8 + i * 16, 8 + @log_y)
      end
      x = 100
      for b in 0...bull
        @image_log.insert(IMAGE_BULL, x, @log_y)
        x += 24
      end
      for c in 0...cow
        @image_log.insert(IMAGE_COW, x, @log_y)
        x += 24
      end
      @log_y += 24
    end

    def locate_init_x(index)
      40 + index * 24
    end

    def locate_init_y
      100
    end

    def locate_hole_x(index)
      96 + index * 36
    end

    def locate_hole_y
      48
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
      target_hole = (@window.mouse_x.to_i - 88) / 36
      # 마우스가 구멍 안에 들어올 때
      if @window.mouse_y >= 40 && @window.mouse_y < 72 && target_hole >= 0 && target_hole < DIGITS
        # 구멍에 있는 숫자를 선택한 경우
        if @balls[number].in_hole == true
          # 꺼낸다
          @balls[number].in_hole = false
          @your_numbers[target_hole] = nil
          @last_pop ||= target_hole
        end
      end
    end

    def m_ball_pickdown(number)
      target_hole = (@window.mouse_x.to_i - 88) / 36
      # 마우스가 구멍 안에 들어올 때
      if @window.mouse_y >= 40 && @window.mouse_y < 72 && target_hole >= 0 && target_hole < DIGITS
        prev_number = @your_numbers[target_hole]
        # 이미 있는 숫자
        if prev_number.is_a?(Integer)
          if @last_pop.is_a?(Integer)
            # 스와핑
            @balls[prev_number].in_hole = true
            @balls[prev_number].nx = locate_hole_x(@last_pop)
            @balls[prev_number].ny = locate_hole_y
            @your_numbers[@last_pop] = prev_number
            @last_pop = nil
          else
            # 원위치
            @balls[prev_number].in_hole = false
            @balls[prev_number].nx = locate_init_x(prev_number)
            @balls[prev_number].ny = locate_init_y
          end
        end
        @balls[number].in_hole = true
        @balls[number].nx = locate_hole_x(target_hole)
        @balls[number].ny = locate_hole_y
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