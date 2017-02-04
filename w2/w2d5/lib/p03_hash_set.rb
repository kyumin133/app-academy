require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    num = key.hash
    bucket = self[num]
    bucket << key unless include?(num)
    @count += 1
  end

  def include?(key)
    num = key.hash
    self[num].include?(key)
  end

  def remove(key)
    num = key.hash
    bucket = self[num]
    bucket.delete_if { |e| e == key  }
    @count -= 1
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
        num = el.hash
        remainder = num % new_size
        new_arr[remainder] << el
      end
    end
    @store = new_arr
  end
end
