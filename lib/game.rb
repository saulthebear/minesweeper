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
      when :load
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
    if %w[s l].include?(input_string)
      command = input_string
    else
      command, position_string = input_string.split(' ')
      raise ArgumentError unless command && position_string

      row, col = position_string.split(',').map(&:to_i)
      position = Position.new(row, col)
      raise(ArgumentError, 'Position Invalid') unless position.valid?(@board.width - 1, @board.height - 1)
    end

    raise(ArgumentError, "`#{command}` is not a valid command") unless %w[s l r f].include?(command)

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
    when 'l'
      load_game
    end
  end

  def load_game
    savegames = list_savegames
    if savegames
      file_index = prompt_for_savegame(savegames)
      open_savegame(savegames[file_index])
    else
      puts 'Sorry, I couldn\'t find any savegames.'.yellow
      sleep(1)
      return :continue
    end

    :load
  end

  def prompt_for_savegame(savegames)
    print_savegames(savegames)
    receive_file_index(savegames.length - 1)
  end

  def open_savegame(savegame_name)
    puts "Okay, I'll open #{savegame_name} for you."
    loaded_game = YAML.load(File.read("savegames/#{savegame_name}"))
    loaded_game.run
  end

  def print_savegames(savegames_found)
    puts 'I found these savegames:'
    savegames_found.each_with_index do |filename, index|
      puts "#{index + 1}: #{filename}"
    end
  end

  def receive_file_index(max_index)
    puts 'Which one would you like to open? (enter the number on the left)'
    print '> '
    loop do
      input = user_input.to_i
      return (input - 1) if input <= (max_index + 1) && input.positive?

      puts 'Invalid input. Please try again.'
      print '> '
    end
  end

  def list_savegames
    return unless Dir.exist?('savegames')

    Dir.entries('savegames')
       .select { |name| name[/game-\d+\.yaml/] }
       .sort
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
