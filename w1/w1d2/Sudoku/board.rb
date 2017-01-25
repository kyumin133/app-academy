require_relative "tile"
require 'colorize'

class Board
  def initialize(grid)
    @grid = grid
  end

  def update_tile(pos, value)
    if valid_addition?(pos, value)
      self[pos] = value
      return true
    else
      return false
    end
  end

  def valid_addition?(pos, value)
    if value < 1 || value > 9
      return false
    end
    row, column = pos
    if row < 0 || row > 8 || column < 0 || column > 8
      return false
    end
    given = self[pos].is_given
    valid_row = check_row?(pos, value)
    valid_col = check_col?(pos, value)
    valid_box = check_box?(pos, value)
    valid_row && valid_col && valid_box && !given
  end

  def check_row?(pos, value)
    for i in (0...@grid[0].length) do
      next if i == pos[1]
      if @grid[pos[0]][i] == value
        return false
      end
    end
    true
  end

  def check_col?(pos, value)
    for i in (0...@grid.length) do
      next if i == pos[0]
      if @grid[i][pos[1]] == value
        return false
      end
    end
    true
  end

  def check_box?(pos, value)
    row, column = pos
    row_trisection = row / 3
    col_trisection = column / 3

    for i in (row_trisection * 3)...((row_trisection + 1)* 3) do
      for j in (col_trisection * 3)...((col_trisection + 1)* 3) do
        # puts "#{i}, #{j}"
        next if i == row && j == column
        if @grid[i][j].value == value
          return false
        end
      end
    end
    true
  end

  def [](pos)
    row, column = pos
    @grid[row][column]
  end

  def []= (pos, value)
    row, column = pos
    @grid[row][column].value = value
  end

  def render
    horizontal_divider = "-------------\n"
    total_string = horizontal_divider
    for i in (0...@grid.length) do
      row = "|"
      for j in (0...@grid[i].length) do
        row += @grid[i][j].to_s
        if j % 3 == 2
          row += "|"
        end
      end
      total_string += row + "\n"
      if i % 3 == 2
        total_string += horizontal_divider
      end
    end
    puts total_string
  end

  def solved?
    for i in 0...@grid.length do
      for j in 0...@grid[i].length do
        if @grid[i][j].value == 0
          return false
        end
      end
    end
    true
  end

  def self.from_file(file_name)
    grid = []
    f = File.open(file_name, "r")
    input = f.readlines
    row_count = 0
    input.each do |r|
      column_count = 0
      r = r.chomp
      row = []
      r.chars.each do |c|
        row << Tile.new(c.to_i)
        column_count += 1
        if column_count >= 9
          break
        end
      end
      grid << row
      row_count += 1
      if row_count >= 9
        break
      end
    end
    f.close
    Board.new(grid)
  end
end
