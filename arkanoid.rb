require 'gosu'

class Ball

  attr_reader :x, :y

  def initialize()
    @image = Gosu::Image.new("./img/item__66.png")
    @x = 500
    @y = 500
    @vel_x = [-3, 3].sample
    @vel_y = [-3, 3].sample
  end

  def update
    if @x >= 1200 - 53 || @x <= 0
      @vel_x *= -1
    end
    if @y >= 900 - 100 || @y <= 0
      @vel_y *= -1
    end
    @x += @vel_x
    @y += @vel_y
  end

  def bounce_off_paddle
    @vel_y *= -1  # Vänd Y-riktningen när bollen studsar på paddeln
  end

  def draw
    @image.draw(@x, @y, 1, 3, 3)
  end

end

class Bounce < Gosu::Window


  def initialize
    super 1200, 900
    self.caption = "Arkanoid!"
    @balls = 2.times.map {|| Ball.new}
    @player = Paddle.new
  end

  def update
    @balls.each {|ball| ball.update}

    @balls.each do |ball|
      ball.update
      if @player.hit_by?(ball)  # Om bollen träffar paddeln
        ball.bounce_off_paddle
      end
    end
  end

  def draw
    @balls.each {|ball| ball.draw}
    @player.draw


    draw_quad(
      0, 0, Gosu::Color::BLUE,           # Vänstra övre hörnet
      width, 0, Gosu::Color::FUCHSIA,        # Högra övre hörnet
      0, height, Gosu::Color::YELLOW,       # Vänstra nedre hörnet
      width, height, Gosu::Color::GREEN    # Högra nedre hörnet
    )
  end


end

class Paddle
  WIDTH = 100
  def initialize()
    @x1 = 550
    @y1 = 750
  end

  def draw
    Gosu::draw_rect(@x1, @y1, WIDTH, 25, Gosu::Color:: WHITE, 1)
  end

  def hit_by?(ball)
    # Kontrollera om bollen överlappar med paddelns rektangel
    ball.x > @x1 && ball.x < @x1 + WIDTH &&
    ball.y + 53 > @y1 && ball.y < @y1 + HEIGHT
  end


end


game = Bounce.new
game.show
