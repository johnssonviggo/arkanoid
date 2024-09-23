require 'gosu'

class Ball
  def initialize
    @image = Gosu::Image.new("./img/item__66.png")
    @x = 500
    @y = 500
  end

  def draw
    @image.draw(@x, @y, 0, 4, 4)
  end

end

class Bounce < Gosu::Window


  def initialize
    super 1200, 900
    self.caption = "Arkanoid!"
    @balls = Ball.new
  end

#   # def update
#   #   @balls.each {|ball| ball.update}
#   # end

  def draw
    @balls.draw
  end


end

game = Bounce.new
game.show
