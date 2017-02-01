class Array
  def my_uniq
    uniq_arr = []
    self.each do |el|
      uniq_arr << el unless uniq_arr.include?(el)
    end
    uniq_arr
  end

  def two_sum
    pos_arr = []
    (0...length).each do |x|
      (x + 1...length).each do |y|
        pos_arr << [x, y] if self[x] + self[y] == 0
      end
    end
    pos_arr
  end

  def my_transpose
    transposed = []
    (0...length).each do |i|
      new_column = []
      self.each do |row|
        new_column << row[i]
      end
      transposed << new_column
    end

    transposed
  end

  def stock_picker
    raise "Array must be at least length 2." if length < 2

    pair = []
    most_profit = 0
    (0...length).each do |x|
      (x + 1...length).each do |y|
        profit = self[y] - self[x]
        if profit > most_profit
          pair = [x, y]
          most_profit = profit
        end
      end
    end

    pair
  end
end
