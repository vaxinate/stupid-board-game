class MoveGrid < Chingu::BasicGameObject
  def initialize(opts  = {})
    super
    @player_position = opts[:position] if opts[:position]
    @player_speed = opts[:speed] if opts[:speed]

    register_valid_moves(@player_position, @player_speed) if @player_position && @player_speed
  end

  def setup
    @grid = Array.new(20) do
      Array.new(20) { false }
    end
    @tile_image = Image["move_overlay.png"]
  end

  def draw
    @grid.each_with_index do |outer, x|
      outer.each_with_index { |val, y| @tile_image.draw( x * 16, y * 16, 1) if val }
    end
  end

  def valid_move? (x, y)
    in_bounds?(x, y) && @grid[x][y]
  end

  private
    def register_valid_moves(pos, speed)
      puts "registering"
      for row in (pos[0] - speed)..(pos[0] + speed)
        for col in (pos[1] - speed)..(pos[1] + speed)
          @grid[row][col] = true if in_bounds?(row, col)
        end
      end
      @grid[pos[0]][pos[1]] = false
    end

    def in_bounds?(row, col)
      bounds = 0..19
      bounds.include?(row) && bounds.include?(col)
    end
end