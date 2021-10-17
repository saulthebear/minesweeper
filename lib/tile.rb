require_relative 'board'

# A single tile on a board.
# Can be a bomb or empty.
# User can flag or reveal a tile.
class Tile

  attr_reader :flagged, :revealed, :fringe

  def initialize(board, position)
    @board = board
    @position = position
    @is_bomb = should_i_be_a_bomb?
    @flagged = false
    @revealed = false
    @fringe = false
  end

  # Determines by random chance if this tile should be a bomb
  # Helper method for initialize
  def should_i_be_a_bomb?
    chance = 0.12
    rand <= chance
  end

  def bomb?
    @is_bomb
  end

  # Reveals to tile, so it can be displayed to the user
  # If the tile is a bomb, return 1.
  def reveal
    @revealed = true
    return 1 if @is_bomb

    0
  end

  # TODO: implement
  def neighbours()
  end

  # TODO: implement
  def neighbour_bomb_count
    rand(8)
  end

  def to_s
    return '   ' unless @revealed
    return ' f ' if @flagged
    return ' X ' if @is_bomb
    return " #{neighbour_bomb_count} " if @fringe

    ' _ '
  end

  def inspect
    "<Tile @position: [#{@position.row},#{@position.col}]
           @is_bomb=#{@is_bomb}
           @flagged=#{@flagged}
           @revealed=#{@revealed}>"
  end
end