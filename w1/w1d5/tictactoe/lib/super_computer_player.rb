require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # build a new TTT node
    node = TicTacToeNode.new(game.board, mark)

    # iterate through children of the node
    # if any children are winning nodes, return that prev_move_pos
    children = node.children
    children.each do |child|
      if child.winning_node?(mark)
        # puts "winning move: #{mark} will move to #{child.prev_move_pos}"
        return child.prev_move_pos
      end
    end

    children.reject! do |child|
      child.losing_node?(mark)
    end

    if children.empty?
      raise "there are no non-losing nodes"
    else
      # puts "no winning move: #{mark} will move randomly"
      return children.sample.prev_move_pos
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
