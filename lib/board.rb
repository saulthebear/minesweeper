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
    print_column_index
    @grid.each_with_index do |row, row_index|
      puts "#{row_index} #{row.map(&:to_s).join}"
    end
    nil
  end

  # For debugging only
  def render_bombs
    print_column_index
    @grid.each_with_index do |row, row_index|
      tile_strings = row.map do |tile|
        # debugger
        # neighbour_bomb_count = 1
        neighbour_bomb_count = tile.neighbour_bomb_count
        if tile.bomb?
          ' X '
        elsif neighbour_bomb_count > 0
          " #{neighbour_bomb_count} "
        else
          # tile.to_s
          ' _ '
        end
      end
      puts "#{row_index} #{tile_strings.join}"
    end
    nil
  end

  def print_column_index
    string = '  '
    (0...@width).each do |col_index|
      string += " #{col_index} "
    end
    puts string
  end

  def [](position)
    raise ArgumentError unless position.is_a?(Position)

    @grid[position.row][position.col]
  end

  def inspect
    "<Board: @grid:#{@height}*#{@width}>"
  end
end
