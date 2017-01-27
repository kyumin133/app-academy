class KnightPathFinder
  BOARD_SIZE = 8
  def initialize(starting_pos)
    @pos = starting_pos
    @visited_positions = [starting_pos]
  end

  def find_path(end_pos)
  end

  def build_move_tree
    #TODO
  end

  def self.on_board?(pos)
    row, col = pos
    return false unless row.between?(0, BOARD_SIZE - 1)
    true
  end

# TEST MEEE!!!!!!
  def self.valid_moves(pos)
    row, col = pos
    increments = [[1,2],[-1,2],[1,-2],[-1,-2],[2, 1],[-2,1],[2,-1],[-2,-1]]
    increments.map { |coord| coord[0], coord[1] = row + coord[0], col + coord[1] }
    increments.select { |move| KnightPathFinder.on_board?(move) }
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos) - @visited_positions
  end


end
p KnightPathFinder.valid_moves([2,2])
