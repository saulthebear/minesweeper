require_relative 'board'
require_relative 'position'

# Holds the main game loop
class Game
  attr_reader :board #TODO: remove

  def initialize(difficulty: 12)
    @board = Board.new(difficulty: difficulty)
  end

  def run
    display_introduction
    1.step do |run_number|
      render(run_number)
      valid_command = receive_command while valid_command.nil?
      if valid_command == 1
        render(run_number)
        puts "BOOM!\n=== GAME OVER ==="
        break
      end

      if @board.win?
        render(run_number)
        puts "\n=== BOARD SOLVED! ==="
        break
      end
    end
  end

  def display_introduction
    system('clear')
    puts "==== Welcome to Minesweeper! ====\n\n"
    puts '=== INSTRUCTIONS ==='
    puts 'Commands are one letter followed by a position, eg.'
    puts '    r 0,4 => reveal row 0 column 4'
    puts '    f 5,2 => flag row 5 column 2'
    puts "\n"
  end

  def render(run_number)
    system('clear') unless run_number.zero?
    @board.render
  end

  def receive_command
    puts 'Enter a command:'
    print '> '
    begin
      command, position = process_input(user_input)
    rescue ArgumentError => error
      puts "Invalid input: #{error.message}"
      nil
    else
      process_command(command, position)
    end
  end

  def process_input(input_string)
    command, position_string = input_string.split(' ')
    raise ArgumentError unless command && position_string

    row, col = position_string.split(',').map(&:to_i)
    position = Position.new(row, col)
    raise(ArgumentError, 'Position Invalid') unless position.valid?(@board.width - 1, @board.height - 1)

    raise(ArgumentError, "`#{command}` is not a valid command") unless %w[r f].include?(command)

    [command, position]
  end

  def process_command(command, position)
    case command
    when 'r'
      reveal(position)
    when 'f'
      flag(position)
    end
  end

  def user_input
    gets.chomp
  end

  def reveal(position)
    @board.reveal(position)
  end

  def flag(position)
    @board.flag(position)
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(difficulty: 5)
  g.run
end
