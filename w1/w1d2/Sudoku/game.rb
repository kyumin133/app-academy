require_relative "board"
require_relative "tile"
class Game
  def initialize(board)
    @board = board
  end

  def play
    while true do
      system("clear")
      @board.render
      pos, value = self.prompt
      @board.update_tile(pos, value)
      break if @board.solved?
    end
    puts "You win!"
  end

  def prompt
    valid_input = false
    pos = []
    while valid_input == false do
      puts "\nEnter position (e.g. 0,0): "
      input = $stdin.gets
      pos = input.chomp.split(",").map { |p| p.to_i}
      valid_input = valid_position?(pos)
      if valid_input == false
        puts "Invalid position."
      end
    end

    valid_input = false
    value = -1
    while valid_input == false do
      puts "Enter value (1-9): "
      input = $stdin.gets
      value = input.chomp.to_i
      valid_input = @board.valid_addition?(pos, value)
      if valid_input == false
        puts "Invalid value."
      end
    end
    [pos, value]
  end

  def valid_position?(pos)
    if pos.length != 2
      return false
    elsif pos[0] < 0 || pos[0] > 8
      return false
    elsif pos[1] < 0 || pos[1] > 8
      return false
    elsif @board[pos].is_given
      return false
    end
    true
  end

end

if __FILE__ == $PROGRAM_NAME
  board = nil
  if ARGV[0] == nil
    board = Board.from_file("sudoku1.txt")
  else
    board = Board.from_file(ARGV[0].chomp)
  end
  game = Game.new(board)
  # board.render
  game.play
end
