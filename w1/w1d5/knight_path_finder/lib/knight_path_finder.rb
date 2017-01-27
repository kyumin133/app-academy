require_relative 'tree_node'

class KnightPathFinder
  BOARD_SIZE = 8
  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited_positions = [starting_pos]
    build_move_tree
  end

  def find_path(end_pos)
    destination_node = @move_tree_root.bfs(end_pos)
    path = trace_path_back(destination_node)
    path << end_pos
    path
  end

  def trace_path_back(destination_node)
    parent = destination_node.parent
    return [] if parent.nil?
    trace_path_back(parent).concat([parent.value])
  end

  def build_move_tree
    queue = []
    @move_tree_root = PolyTreeNode.new(@starting_pos)
    queue << @move_tree_root

    until queue.empty?
      current_node = queue.shift
      new_positions = new_move_positions(current_node.value)

      new_positions.each do |position|
        new_node = PolyTreeNode.new(position)
        new_node.parent = current_node
        queue << new_node
      end
    end

    @move_tree_root
  end

  def self.on_board?(pos)
    row, col = pos
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end

  def self.valid_moves(pos)
    row, col = pos
    increments = [
      [1,2],[-1,2],[1,-2],[-1,-2],
      [2, 1],[-2,1],[2,-1],[-2,-1]
    ]

    increments.map do |coord|
      coord[0], coord[1] = row + coord[0], col + coord[1]
    end

    increments.select { |move| KnightPathFinder.on_board?(move) }
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos) - @visited_positions
    @visited_positions.concat(new_positions)
    new_positions
  end


end
