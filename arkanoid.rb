require 'gosu'

class Ball

  attr_reader :x, :y, :width, :height, :vel_y, :vel_x

  def initialize()
    @image = Gosu::Image.new("./img/item__66.png")
    @x = 500
    @y = 500
    @vel_x = [-4, 4].sample
    @vel_y = [-4, 4].sample
    @width = 53
    @height = 53
  end

  def update
    if @x >= 1200 - @width || @x <= 0
      @vel_x *= -1
    end
    if @y <= 0
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
    # @balls = 2.times.map {|| Ball.new}
    @ball = Ball.new
    @player = Paddle.new
  end

  def update
    @player.move_left if button_down?(Gosu::KB_LEFT)
    @player.move_right if button_down?(Gosu::KB_RIGHT)

    @ball.update
      if @player.hit_by?(@ball)  # Om bollen träffar paddeln
        @ball.bounce_off_paddle
      end





    # @balls.each {|ball| ball.update}
    # @balls.each do |ball|
  end

  def draw
    # @balls.each {|ball| ball.draw}
    @ball.draw
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
  @direction = nil
  WIDTH = 100
  SPEED = 10
  HEIGHT = 25
  def initialize()
    @x1 = 550
    @y1 = 750
  end

  def move_left
    @x1 -= SPEED unless @x1 <= 0  # Begränsar paddeln så att den inte går utanför vänster sida
  end

  def move_right
    @x1 += SPEED unless @x1 + WIDTH >= 1200  # Begränsar paddeln så att den inte går utanför höger sida
  end

  def hit_by?(ball)
    # Kontrollera om bollen överlappar med paddelns rektangel
    # ball.x > @x1 && ball.x < @x1 + WIDTH &&
    # ball.y + 53 > @y1 && ball.y < @y1 + HEIGHT

    if ball.y + ball.height >= @y1 && ball.y + ball.height <= @y1 + HEIGHT &&
      ball.x + ball.width > @x1 && ball.x < @x1 + WIDTH && ball.vel_y > 0
     true
   else
     false
   end
  end


  def draw
    Gosu::draw_rect(@x1, @y1, WIDTH, HEIGHT, Gosu::Color:: WHITE, 1)
  end

end


game = Bounce.new
game.show
