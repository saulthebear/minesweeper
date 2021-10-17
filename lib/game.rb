require_relative 'board'

# Holds the main game loop
class Game
  def initialize
    @board = Board.new
  end

  def run() end

  def render() end

  def receive_command() end

  def flag(position) end

  def reveal(position) end

end
