require_relative 'board'

# A single tile on a board.
# Can be a bomb or empty.
# User can flag or reveal a tile.
class Tile
  def initialize(board, position, difficulty)
    @board = board
    @position = position
    @is_bomb = should_i_be_a_bomb?(difficulty)
    @flagged = false
    @revealed = false
    @neighbours = nil
  end

  # Determines by random chance if this tile should be a bomb
  # Helper method for initialize
  def should_i_be_a_bomb?(difficulty)
    chance = difficulty / 100.0
    rand <= chance
  end

  def fringe?
    neighbour_bomb_count.positive?
  end

  def bomb?
    @is_bomb
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  # Reveals to tile, so it can be displayed to the user
  # If the tile is a bomb, return 1.
  def reveal
    return 0 if @flagged
    return 1 if @is_bomb

    @revealed = true
    reveal_neighbours unless fringe?

    0
  end

  def flag
    @flagged = true
  end

  def reveal_neighbours
    neighbours.each do |n|
      next if n.bomb?

      n.reveal unless n.revealed?
    end
  end

  def neighbours
    return @neighbours if @neighbours

    neighbour_tiles = []
    positions = neighbours_positions
    positions.each do |pos|
      neighbour_tiles << @board[pos]
    end
    neighbour_tiles
  end

  def neighbours_positions
    positions = []
    min_row = @position.row - 1
    max_row = @position.row + 1
    min_col = @position.col - 1
    max_col = @position.col + 1

    (min_row..max_row).each do |row_index|
      (min_col..max_col).each do |col_index|
        next if row_index == @position.row && col_index == @position.col

        pos = Position.new(row_index, col_index)
        positions << pos if pos.valid?(@board.height - 1, @board.width - 1)
      end
    end

    positions
  end

  def neighbour_bomb_count
    neighbours.count(&:bomb?)
  end

  def to_s
    return ' * ' unless revealed? || flagged?
    return ' f ' if @flagged
    return ' X ' if @is_bomb
    return " #{neighbour_bomb_count} " if fringe?

    ' _ ' # Normal squares if revealed
  end

  def inspect
    "<Tile @position: [#{@position.row},#{@position.col}]
           @is_bomb=#{@is_bomb}
           @flagged=#{flagged?}
           @revealed=#{revealed?}>"
  end
end
