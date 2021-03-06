require 'colorize'

require_relative 'tile'
require_relative 'position'

# Holds a grid of tiles.
class Board
  attr_reader :grid #TODO: Remove. For debugging only
  attr_reader :height, :width

  def initialize(height: 9, width: 9, difficulty: 12)
    @height = height
    @width = width
    @difficulty = difficulty
    create_grid
  end

  def create_grid
    @grid = []
    @height.times do |row_index|
      row = []
      @width.times do |col_index|
        position = Position.new(row_index, col_index)
        tile = Tile.new(self, position, @difficulty)
        row << tile
      end
      @grid << row
    end
  end

  def reveal(position)
    tile = self[position]
    tile.reveal
  end

  def flag(position)
    tile = self[position]
    tile.flag
  end

  def render
    print_column_index
    @grid.each_with_index do |row, row_index|
      puts "#{row_index} #{row.map(&:to_s).join}"
    end
    nil
  end

  def render_bombs(position_lost = nil)
    print_column_index
    @grid.each_with_index do |row, row_index|
      tile_strings = render_bombs_row(row, position_lost)
      puts "#{row_index} #{tile_strings.join}"
    end
    nil
  end

  def render_bombs_row(row, position_lost = nil) # rubocop:disable Metrics/MethodLength
    row.map do |tile|
      neighbour_bomb_count = tile.neighbour_bomb_count
      if tile.flagged? && tile.bomb?
        Tile.tile_string(:flagged)
      elsif tile.flagged?
        Tile.tile_string(:flagged_incorrect)
      elsif tile.bomb? && tile.position == position_lost
        Tile.tile_string(:exploded_bomb)
      elsif tile.bomb?
        Tile.tile_string(:bomb)
      elsif tile.fringe? && tile.revealed?
        Tile.tile_string(:fringe, neighbour_bomb_count)
      elsif tile.revealed?
        Tile.tile_string(:revealed)
      else
        Tile.tile_string(:unexplored)
      end
    end
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

  def win?
    @grid.all? do |row|
      row.all? do |tile|
        tile.revealed? || (tile.bomb? && tile.flagged?)
      end
    end
  end

  def inspect
    "<Board: @grid:#{@height}*#{@width} @difficulty:#{@difficulty}>"
  end
end
