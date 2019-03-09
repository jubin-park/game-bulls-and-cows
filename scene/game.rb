class Scene
  class Game

    DIGITS = 4

    def initialize(window)
      @window = window
      @background = Gosu::Image.new("img/background.png")
      @holes = Array[Gosu::Image.new "img/hole.png"] * DIGITS
      @balls = Array.new(10) {|i| NumberBall.new(window, 40 + i * 24, 100, 3, i)}
      @balls.each do |ball|
        ball.set_method(:mouse_down, method(:ball_pickdown))
        ball.set_method(:mouse_up, method(:ball_pickup))
      end
      p @rand_numbers = generate_random_number(DIGITS)
      @your_numbers = Array.new(DIGITS)
    end

    def draw
      @background.draw(0, 0, 0)
      @holes.each_index {|i| @holes[i].draw(88 + i * 36, 40, 1)}
      @balls.each{|ball| ball.draw}
      Gosu.draw_rect(24, 176, 272, 120, Gosu::Color.argb(128, 0, 0, 0), 0)
    end

    def update
      @balls.each{|ball| ball.update}
    end

    def ball_pickdown(number)
      h_index = (@window.mouse_x.to_i - 88) / 36
      # 마우스가 구멍 안에 들어올 때
      if @window.mouse_y >= 40 && @window.mouse_y < 72 && h_index >= 0 && h_index < DIGITS
        # 구멍에 있는 숫자를 선택한 경우
        if @balls[number].in_hole == true
          @balls[number].in_hole = false
          @balls[number].picked = true
          @your_numbers[h_index] = nil
          @last ||= h_index
          return
        end
        # 이미 있는 숫자
        prev_number = @your_numbers[h_index]
        if prev_number.is_a? Integer
          if @last.is_a? Integer
            # 스와핑
            @balls[prev_number].in_hole = true
            @balls[prev_number].nx = 96 + @last * 36
            @balls[prev_number].ny = 48
            @your_numbers[@last] = prev_number
            @last = nil
          else
            # 원위치
            @balls[prev_number].in_hole = false
            @balls[prev_number].nx = 40 + prev_number * 24
            @balls[prev_number].ny = 100
          end
        end
        @balls[number].in_hole = true
        @balls[number].nx = 96 + h_index * 36
        @balls[number].ny = 48
        @your_numbers[h_index] = number
        p @your_numbers
      else
        @balls[number].in_hole = false
        @balls[number].nx = 40 + number * 24
        @balls[number].ny = 100
        @last = nil
      end
    end

    def ball_pickup(number)

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