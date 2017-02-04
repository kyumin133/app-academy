class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end

    nil
  end

  def include?(key)
    #RIP error
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    # puts "Value passed into append: #{val}"
    old_end = last
    new_node = Link.new(key, val)
    old_end.next = new_node
    new_node.prev = old_end
    new_node.next = @tail
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    return unless include?(key)
    get_node(key).val = val
    end

  def remove(key)
    return unless include?(key)
    node = get_node(key)
    node.remove
  end

  def each(&prc)
    node = first
    while node != @tail
      prc.call(node)
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def get_node(key)
    each do |node|
      return node if node.key == key
    end

    nil
  end

  # uncomment when you have `each` working and `Enumerable` included

end
