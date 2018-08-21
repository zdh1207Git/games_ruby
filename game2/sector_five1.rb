require 'gosu'
require_relative 'player1'
require_relative 'enemy'
require_relative 'bullet1'
require_relative 'explosion'

class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.03

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sector Five'
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
  end

  def draw
    @player.draw
    enemies_draw
    bullets_draw
    explosion_draw
  end

  def update
    @player.go_left if button_down?(Gosu::KbA)
    @player.go_right if button_down?(Gosu::KbD)
    @player.accelerate if button_down?(Gosu::KbW)
    @player.accelerate_down if button_down?(Gosu::KbS)
    @player.move
    enemies_add
    enemies_move
    bullets_move
    explode
  end

  def button_down(id)
    if id == Gosu::KbSpace
      [-60, -50, -40, -30, -20, -10, 0, 10, 20, 30, 40, 50, 60].each do |direction|
        @bullets.push Bullet.new(self, @player.x, @player.y, direction)
      end
    end
  end

  private

  def enemies_draw
    @enemies.each { |enemy| enemy.draw }
  end

  def bullets_draw
    @bullets.each { |bullet| bullet.draw }
  end

  def explosion_draw
    @explosions.each { |explosion| explosion.draw }
  end

  def enemies_move
    @enemies.each { |enemy| enemy.move }
  end

  def enemies_add
    @enemies.push Enemy.new(self) if rand < ENEMY_FREQUENCY
  end

  def bullets_move
    @bullets.each { |bullet| bullet.move }
  end

  def explode
    @enemies.each do |enemy|
      @bullets.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
        end
      end
    end
    delete
  end

  def delete
    @explosions.dup.each do |explosion|
      @explosions.delete explosion if explosion.finished
    end

    @enemies.dup.each do |enemy|
      if enemy.y > HEIGHT + enemy.radius
        @enemies.delete enemy
      end
    end

    @bullets.dup.each do |bullet|
      @bullets.delete bullet unless bullet.onscreen?
    end
  end
end
window = SectorFive.new
window.show
