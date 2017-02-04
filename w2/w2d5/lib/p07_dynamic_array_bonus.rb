require "byebug"
class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count
  include Enumerable
  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= capacity
    return @store[i] if i >= 0
    return nil if i * -1 > @count
    # byebug
    counter = @count + i
    target_value = nil
    each_with_index do |el , idx|
      break if counter < 0
      target_value = el
      counter -= 1
    end

    target_value
  end

  def []=(i, val)
    resize! if i >= capacity
    if i >= 0
        @count += 1 if @store[i].nil?
        @store[i] = val
    else
      return nil if i * -1 > @count
      @store[get_last_index[0] + i + 1] = val
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end

    false
  end

  def push(val)
    last_index = get_last_index[0]
    if last_index.nil?
      self[0] = val
    else
      self[get_last_index[0] + 1] = val
    end
  end

  def unshift(val)
    resize! if get_last_index[0] >= capacity - 1
    unless first.nil?
      last_index = get_last_index[0]
      last_index.downto(0) do |i|
        @store[i + 1] = @store[i]
      end
    end
    self[0] = val
  end

  def pop
    last_index, last_value =  get_last_index
    return nil if last_index.nil?
    self[last_index] = nil
    @count -= 1
    last_value
  end

  def shift
    # debugger
    first_index, first_value =  get_first_index
    return nil if first_index.nil?
    ((first_index + 1)...capacity).each do |i|
      @store[i - 1] = @store[i]
      @store[i] = nil
    end
    @count -= 1
    first_value
  end

  def first
    get_first_index[1]
  end

  def last
    get_last_index[1]
  end



  def each
    (0...capacity).each do |i|
      next if @store[i].nil?
      yield @store[i]
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    return false if length != other.length

    other.each_with_index do |el, i|
      return false if el != self[i]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    each_with_index do |el , i |
      new_store[i] = el
    end
    @store = new_store
  end

  def get_last_index
    last_value = nil
    last_index = nil

    each_with_index do |el, i|
      last_value = el
      last_index = i
    end

    [last_index, last_value]
  end

  def get_first_index
    (0...capacity).each do |i|
      return [i, @store[i]] unless @store[i].nil?
    end
    [nil, nil]
  end

end
