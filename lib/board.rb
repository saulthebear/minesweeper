require_relative 'tile'
require_relative 'position'

# Holds a grid of tiles.
class Board
  attr_reader :grid

  def initialize(size = 9)
    @size = size
    create_grid
  end

  def create_grid
    @grid = []
    @size.times do |row_index|
      row = []
      @size.times do |col_index|
        position = Position.new(row_index, col_index)
        tile = Tile.new(self, position)
        row << tile
      end
      @grid << row
    end
  end

  def render
    @grid.each do |row|
      puts row.map(&:to_s).join
    end
    nil
  end

  def inspect
    "<Board: @grid:#{@size}*#{@size}>"
  end
end
