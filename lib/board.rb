require_relative 'tile'

# Holds a grid of tiles.
class Board
  attr_reader :grid

  def initialize(size = 9)
    @size = size
    @grid = create_grid
  end

  def create_grid
    Array.new(@size) do 
      Array.new(@size) { Tile.new(self) }
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
