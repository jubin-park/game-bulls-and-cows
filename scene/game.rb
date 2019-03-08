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
      @pick = nil
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
      @pick = number
      hx = (@window.mouse_x.to_i - 88) / 36
      my = @window.mouse_y.to_i
      # 숫자가 구멍 안에 들어올 때
      if my >= 40 && my < 72 && hx >= 0 && hx < DIGITS
        old_number = @your_numbers[hx]
        # 이미 숫자가 존재한 경우
        if old_number.is_a?(Integer)
          # 원위치
          @balls[old_number].nx = 40 + old_number * 24
          @balls[old_number].ny = 100
        end
        @your_numbers[hx] = number
        @balls[number].nx = 96 + hx * 36
        @balls[number].ny = 48
        p @your_numbers
        @pick = nil
      else
        @balls[number].nx = 40 + number * 24
        @balls[number].ny = 100
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