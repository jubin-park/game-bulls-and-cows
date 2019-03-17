class Scene
  class Game

    DIGITS = 4

    def initialize(window)
      @window = window
      @background = Gosu::Image.new("img/background.png")
      @holes = Array[Gosu::Image.new "img/hole.png"] * DIGITS
      @balls = Array.new(10) {|i| NumberBall.new(window, 40 + i * 24, 100, 3, i)}
      @balls.each do |ball|
        ball.set_method(:pick_up, method(:m_ball_pickup))
        ball.set_method(:pick_down, method(:m_ball_pickdown))
      end
      @button_hit = Button.new(@window, 32, 32)
      @button_hit.x = @window.width / 2 - 16
      @button_hit.y = 128
      @button_hit.z = 2
      @button_hit.set_image(0, Gosu::Image.new("img/button-hit.png"))
      @button_hit.set_image(1, Gosu::Image.new("img/button-hit.png"))
      @button_hit.set_method(:mouse_down, method(:hit_down))
      @button_hit.set_method(:mouse_up, method(:hit_up))
      p @rand_numbers = generate_random_number(DIGITS)
      @your_numbers = Array.new(DIGITS)
    end

    def hit_down
      @button_hit.y += 1
    end

    def hit_up
      @button_hit.y -= 1
      bull = cow = 0
      if @your_numbers.include?(nil)
        p "Please fill the all numbers"
        return
      end
      for i in 0...DIGITS
        if @rand_numbers[i] == @your_numbers[i]
          bull += 1
        else
          if @rand_numbers.include?(@your_numbers[i])
            cow += 1
          end
        end
      end
      p "bull:#{bull}, cow:#{cow}"
    end

    def draw
      @background.draw(0, 0, 0)
      @holes.each_index {|i| @holes[i].draw(88 + i * 36, 40, 1)}
      @balls.each{|ball| ball.draw}
      @button_hit.draw
      draw_log
    end

    def draw_log
      Gosu.draw_rect(24, 176, 272, 120, Gosu::Color.argb(128, 0, 0, 0), 0)
    end

    def update
      @balls.each{|ball| ball.update}
      @button_hit.update
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
          p @your_numbers
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
        p @your_numbers
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