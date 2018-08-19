require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'

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
  end

  def draw
    @player.draw
    enemies_draw
    bullets_draw
  end

  def update
    @player.turn_left if button_down?(Gosu::KbA)
    @player.turn_right if button_down?(Gosu::KbD)
    @player.accelerate if button_down?(Gosu::KbW)
    @player.move
    enemies_add
    enemies_move
    bullets_move
    explode
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end

  private

  def enemies_draw
    @enemies.each { |enemy| enemy.draw }
  end

  def bullets_draw
    @bullets.each { |bullet| bullet.draw }
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
        end
      end
    end
  end
end

window = SectorFive.new
window.show
