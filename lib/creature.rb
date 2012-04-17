class Creature < Chingu::GameObject
  attr_accessor :name, :speed, :position, :enchantments
  attr_writer :selected

  def self.selected
    all.select { |cr| cr.selected? }
  end

  def initialize(options)
    super
    @name = options[:name] if options[:name]
    @board = options[:board] if options[:board]
  end

  def setup
    # @image = Image['wizard.png']
    self.speed = 4
  end

  def draw(x, y, z)
    Image['wizard.png'].draw(x, y, z, 2, 2)
  end

  def selected?
    @selected
  end

  def select!
    Creature.each { |cr| cr.deselect! }
    @selected = true
    self
  end

  def deselect!
    @selected = false
    self
  end

  # def position
  #   index = @board.grid.find_index { |tile| tile.include? self }
  #   puts self.name
  #   puts index.class
  #   index
  # end

  def move_grid
    MoveGrid.new :position => self.position, :speed => self.speed
  end

  # def pick_up(ball)
  #   @ball = ball
  # end

  # def drop_ball
  #   temp = @ball
  #   @ball = nil
  #   temp
  # end


  # def move_to(x, y)
  #   @board.move_to(self, x, y) if @board
  # end

end
