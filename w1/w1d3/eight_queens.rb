class EightQueens
  def initialize(n = 8)
    @num_queens = n
    @grid = []
    for i in 0...@num_queens do
      row = []
      for j in 0...@num_queens do
        row << 0
      end
      @grid << row
    end
  end

  def solve(positions)
    return positions if positions.length == @num_queens
    row = positions.length
    valid_cols = []
    for i in 0...@num_queens do
      valid_cols << i if @grid[row][i] == 0
    end
    return [] if valid_cols.empty?

    valid_cols.each do |col|
      add_queen(row, col)
      new_positions = solve(positions + [col])
      if new_positions.empty? == false
        return new_positions
      else
        remove_queen(row, col)
      end
    end
    []
  end

  def add_queen(row, col)
    for i in 0...@num_queens do
      @grid[row][i] += 1 if @grid[row][i] != -1
      @grid[i][col] += 1 if @grid[i][col] != -1
    end

    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    directions.each { |dir| increment_diagonal_conflicts(row, col, dir, 1) }
    @grid[row][col] = -1
  end

  def remove_queen(row, col)
    for i in 0...@num_queens do
      @grid[row][i] -= 1 if @grid[row][i] != -1
      @grid[i][col] -= 1 if @grid[i][col] != -1
    end

    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    directions.each { |dir| increment_diagonal_conflicts(row, col, dir, -1)}
    @grid[row][col] = 0
  end

  def increment_diagonal_conflicts(row, col, direction, increment)
    i, j = (row + direction[0]), (col + direction[1])
    while i >= 0 && j >= 0 && i < @num_queens && j < @num_queens
      if @grid[i][j] != -1
        @grid[i][j] += increment
      end
      i += direction[0]
      j += direction[1]
    end
  end



  def render
    string = "\n"
    for i in 0...@num_queens do
      row = ""
      for j in 0...@num_queens do
        if @grid[i][j] < 0
          row << "Q"
        else
          row << "."
        end
        row << " "
      end
      row << "\n"
      string << row
    end
    puts string
  end

end


a = EightQueens.new
p a.solve([])
a.render
