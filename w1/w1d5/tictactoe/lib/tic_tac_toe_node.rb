require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      winner = @board.winner
      if winner.nil? || winner == evaluator
        return false
      else
        return true
      end
    else
      children = self.children
      if @next_mover_mark == evaluator
        return children.all?{|child| child.losing_node?(evaluator)}
      else
        return children.any?{|child| child.losing_node?(evaluator)}
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      winner = @board.winner
      return winner == evaluator
    else
      children = self.children
      if @next_mover_mark == evaluator
        return children.any?{|child| child.winning_node?(evaluator)}
      else
        return children.all?{|child| child.winning_node?(evaluator)}
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_positions = @board.get_empty_positions
    children_arr = []

    empty_positions.each do |pos|
      child_board = @board.dup
      child_board[pos] = @next_mover_mark
      new_mark = @next_mover_mark == :x ? :o : :x
      children_arr << TicTacToeNode.new(child_board, new_mark, pos)
    end
    children_arr
  end

end
