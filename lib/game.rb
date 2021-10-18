require 'yaml'
require 'colorize'

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
      valid_command, position_played = receive_command while valid_command.nil?

      case valid_command
      when :bomb
        game_lost(position_played)
        break
      when :save
        break
      end

      if @board.win?
        game_won
        break
      end
    end
  end

  def game_lost(position_lost)
    system('clear')
    puts "  *** BOOM! ***\n"
    @board.render_bombs(position_lost)
    puts "\n=== GAME OVER ===\n".red
  end

  def game_won
    render(1)
    puts "\n=== BOARD SOLVED! ===".light_green
  end

  def display_introduction
    system('clear')
    puts "============= Welcome to Minesweeper! =============\n".red
    puts '================== INSTRUCTIONS ==================='.yellow
    puts 'Commands are one letter followed by a position, eg.'.yellow
    puts '    r 0,4 => reveal row 0 column 4'.yellow
    puts '    f 5,2 => flag row 5 column 2'.yellow
    puts "#{'=' * 51}\n\n".yellow
  end

  def render(run_number)
    system('clear') unless run_number == 1
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
    if input_string == 's'
      command = input_string
    else
      command, position_string = input_string.split(' ')
      raise ArgumentError unless command && position_string

      row, col = position_string.split(',').map(&:to_i)
      position = Position.new(row, col)
      raise(ArgumentError, 'Position Invalid') unless position.valid?(@board.width - 1, @board.height - 1)
    end

    raise(ArgumentError, "`#{command}` is not a valid command") unless %w[s r f].include?(command)

    [command, position]
  end

  def process_command(command, position)
    case command
    when 'r'
      [reveal(position), position]
    when 'f'
      [flag(position), position]
    when 's'
      save_game
    end
  end

  def save_game
    filename = next_filename
    puts "Saving the game as #{filename}."
    File.write(filename, to_yaml)
    :save
  end

  def next_filename
    Dir.mkdir('savegames') unless Dir.exist?('savegames')
    filename = ''
    1.step do |num|
      filename = "savegames/game-#{format('%03d', num)}.yaml"
      break unless File.exist?(filename)
    end
    filename
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
