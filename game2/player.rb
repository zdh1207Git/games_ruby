class Player
  attr_reader :x, :y, :angle, :radius
  ROTATION_SPEED = 3
  ACCELERATION = 2
  FRICTION = 0.9

  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0
    @image = Gosu::Image.new('images/cannon1.png')
    @velocity_x = 0
    @velocity_y = 0
    @radius = 20
    @window = window
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end

  def accelerate
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end

  def move
    x_right = @window.width - @radius
    y_bottom = @window.height - @radius
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION
    if @x > x_right
      @velocity_x = 0
      @x = x_right
    end

    if @x < @radius
      @velocity_x = 0
      @x = @radius
    end

    if @y > y_bottom
      @velocity_y = 0
      @y = y_bottom
    end
  end
end
