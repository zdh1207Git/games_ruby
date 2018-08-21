class Bullet
  attr_reader :x, :y, :radius
  SPEED = 5

  def initialize(window, x, y, direction)
    @x = x
    @y = y
    @direction = direction
    @image = Gosu::Image.new('images/bullet.png')
    @radius = 7.5
    @window = window
  end

  def move
    @x += Gosu.offset_x(@direction, SPEED)
    @y += Gosu.offset_y(@direction, SPEED)
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def onscreen?
    right = @window.width + @radius
    left = -@radius
    top = -@radius
    bottom = @window.height + @radius
    @x > left and @x < right and @y > top and @y < bottom
  end
end
