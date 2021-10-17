require_relative 'tile'
require_relative 'position'

# Holds a grid of tiles.
class Board
  attr_reader :grid, :height, :width

  def initialize(height = 9, width = 9)
    @height = height
    @width = width
    create_grid
  end

  def create_grid
    @grid = []
    @height.times do |row_index|
      row = []
      @width.times do |col_index|
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

  def [](position)
    raise ArgumentError unless position.is_a?(Position)

    @grid[position.row][position.col]
  end

  def inspect
    "<Board: @grid:#{@height}*#{@width}>"
  end
end
