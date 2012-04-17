class Board < GameObject
  attr_reader :grid

  def setup
    @grid = Matrix.build(20) { Tile.new }
    @floor_tile = Image["floortile.bmp"]

    ['steve', 'stan', 'kyle'].each { |n| place(Creature.new :name => n, :board => self) }
  end

  def draw
    @grid.each_with_index do |tile, x, y|
      @floor_tile.draw(x * 16, y * 16, 0, 2, 2)
      tile.each { |e| e.draw(x * 16, y * 16, 2) }
    end
  end

  def place(obj)
    x = rand(20)
    y = rand(20)

    obj.position = [x, y]
    @grid[x, y] << obj
  end

  def select
    x = $window.mouse_x / 16
    y = $window.mouse_y / 16

    clicked = @grid[x, y].select { |obj| obj.is_a? Creature }
    clicked[0].select! unless clicked.empty?
  end

  # def move_to(thing, x_coord, y_coord)
  #   coords = @grid.index thing
  #   @grid[x_coord, y_coord] << @grid[coords].delete(thing)
  # end

end

class Tile < Array
  def get_creature
    self.select { |obj| obj.is_a? Creature }.first
  end
end
