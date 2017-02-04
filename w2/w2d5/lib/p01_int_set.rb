class MaxIntSet

  def initialize(max)
    @set = Array.new(max){false}
  end

  def insert(num)
   check_if_valid(num)
    @set[num] = true
  end

  def remove(num)
      check_if_valid(num)
    @set[num] = false
  end

  def include?(num)
    check_if_valid(num)
    @set[num]
  end

  private

  def check_if_valid(num)
    raise 'Out of bounds' if num < 0 || num >= @set.length
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    bucket << num unless include?(num)
  end

  def remove(num)
    bucket = self[num]
    bucket.delete_if { |e| e == num  }
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
      remainder = num % num_buckets
      @store[remainder]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # call resize if ....
    resize! if @count >= num_buckets
    bucket = self[num]
    bucket << num unless include?(num)
    @count += 1
  end

  def remove(num)
    # call resize if ....
    bucket = self[num]
    bucket.delete_if { |e| e == num  }
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    remainder = num % num_buckets
    @store[remainder]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets * 2
    new_arr = Array.new(new_size) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        remainder = el % new_size
        new_arr[remainder] << el
      end
    end
    @store = new_arr
  end
end
