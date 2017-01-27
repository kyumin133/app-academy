class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value = "new_node")
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    @parent.children.delete_if{|child| child == self} unless @parent.nil?
    unless parent.nil?
      @parent = parent
      @parent.children << self unless parent.children.include?(self)
    else
      @parent = nil
    end
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise "Not a child" unless child_node.parent == self
    child_node.parent = nil
  end

  def dfs(target)
    return self if @value == target
    result = nil

    @children.each do |child|
      result = child.dfs(target)
      return result if result && result.value == target
    end

    result
  end

  def bfs(target)
    queue = []
    queue << self

    until queue.empty?
      node = queue.shift
      return node if node.value == target
      queue.concat(node.children)
    end

    nil
  end

end
