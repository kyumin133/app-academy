require_relative "board"
require_relative "player"

class Game

  def initialize(board = Board.new, player=nil)
    @board = board
    if player.nil?
      @player = HumanPlayer.new(@board)
    else
      @player = player
    end
    @max_turns = @board.num_values * 2
  end

  def play
    @turn = 0
    while self.game_over? == false do
      system("clear")
      @board.render
      first_pos, second_pos = @player.prompt
      sleep(2)
      # system("clear")
      if @board[first_pos] != @board[second_pos]
        @board[first_pos].hide
        @board[second_pos].hide
      end
      @turn += 1
    end
    if @board.won?
      puts "You win!"
    else
      puts "You lose!"
    end
  end

  def game_over?
    @board.won? || @turn >= @max_turns
  end


end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  computer = ComputerPlayer.new(board)
  game = Game.new(board, computer)
  game.play
end
