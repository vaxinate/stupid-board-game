#!/usr/bin/env ruby
require 'chingu'
require 'matrix'

ENV['PATH'] = File.join(ROOT,"lib") + ";" + ENV['PATH']

include Gosu
include Chingu

require_all File.join(ROOT, "lib")


class Game < Chingu::Window
  def initialize
    self.input = {:left_mouse_button => :select_creature}
    super(320, 320)
  end

  def setup
    @board = Board.new
    self.cursor = true
  end

  def update
    selection = Creature.selected
    self.caption = "selected: #{Creature.selected[0].name}" unless selection.empty?
  end

  def draw
    @board.draw
    @move_grid.draw if @move_grid
  end

  def select_creature
    x = self.mouse_x / 16
    y = self.mouse_y / 16

    selected_creature = @board.grid[x, y].get_creature

    if selected_creature
      selected_creature.select!
      @move_grid = selected_creature.move_grid
    end
  end

end

Game.new.show