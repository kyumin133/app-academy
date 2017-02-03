class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @store = []
    @max = -1.0/0.0
    @min = 1.0/0.0
  end

  def pop
    popped = @store.pop
    @max = @store.max if @max == popped
    @min = @store.min if @min == popped
    if empty?
      @max = -1.0/0.0
      @min = 1.0/0.0
    end
    popped
  end

  def push(el)
    @store << el
    @max = el if el > @max
    @min = el if el < @min
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  def max
    @max
  end

  def min
    @min
  end
end

class StackQueue
  def initialize
    @push_stack = MyStack.new
    @pull_stack = MyStack.new
  end

  def enqueue(el)
    @push_stack.push(el)
  end


  def dequeue
    fill_pull_stack if @pull_stack.empty?
    @pull_stack.pop
  end

  def fill_pull_stack
    until @push_stack.empty?
      @pull_stack.push(@push_stack.pop)
    end
  end

  def peek
    fill_pull_stack if @pull_stack.empty?
    @pull_stack.peek
  end

  def size
    @push_stack.length + @pull_stack.length
  end

  def empty?
    @push_stack.empty? && @pull_stack.empty?
  end
end

class MinMaxStackQueue
  def initialize
    @push_stack = MyStack.new
    @pull_stack = MyStack.new
  end

  def enqueue(el)
    @push_stack.push(el)
  end


  def dequeue
    fill_pull_stack if @pull_stack.empty?
    @pull_stack.pop
  end

  def fill_pull_stack
    until @push_stack.empty?
      @pull_stack.push(@push_stack.pop)
    end
  end

  def peek
    fill_pull_stack if @pull_stack.empty?
    @pull_stack.peek
  end

  def size
    @push_stack.length + @pull_stack.length
  end

  def empty?
    @push_stack.empty? && @pull_stack.empty?
  end

  def max
    push_max = @push_stack.max.nil? ? -1.0/0.0 : @push_stack.max
    pull_max = @pull_stack.max.nil? ? -1.0/0.0 : @pull_stack.max
    [push_max,pull_max].max
  end

  def min
    push_min = @push_stack.min.nil? ? 1.0/0.0 : @push_stack.min
    pull_min = @pull_stack.min.nil? ? 1.0/0.0 : @pull_stack.min
    [push_min,pull_min].min
  end
end

if __FILE__ == $PROGRAM_NAME
  sq = MinMaxStackQueue.new
  sq.enqueue(5)
  puts "Max: #{sq.max}. Min: #{sq.min}"
  sq.enqueue(3)
  puts "Max: #{sq.max}. Min: #{sq.min}"
  sq.enqueue(6)
  puts "Max: #{sq.max}. Min: #{sq.min}"
  sq.enqueue(-1)
  puts "Max: #{sq.max}. Min: #{sq.min}"
  # s = MyStack.new
  # s.push(5)
  # p s.min
  # s.push(3)
  # p s.min
  # s.push(6)
  # p s.min
  # s.push(-1)
  # p s.min
  #


end
