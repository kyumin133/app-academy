class TowersOfHanoi

  attr_accessor :board, :tower0, :tower1, :tower2
  def initialize(height = 3)
    @height = height
    @tower0 = (1..height).to_a
    @tower1, @tower2 = [], []
    #@board = [@tower0, @tower1, @tower2]
  end

  def move(source, target)
    raise "Positions must be different." if source == target
    raise "Positions must be between 0 and 2." unless source.between?(0, 2) && target.between?(0, 2)
    raise "Source cannot be empty." if get_tower(source).empty?
    unless get_tower(target).empty?
      raise "Larger disk cannot be moved onto smaller disk." if get_tower(source).first > get_tower(target).first
    end

    disk = get_tower(source).shift
    get_tower(target).unshift(disk)
  end


  def won?
    return false unless @tower0.empty?

    @tower1.empty? || @tower2.empty?
  end

  private
  def get_tower(idx)
    case idx
    when 0
      @tower0
    when 1
      @tower1
    when 2
      @tower2
    end
  end
end

# array of three arrays, each representing a tower/stack
# "top" of each tower is at the beginning.
# initially, all pieces are in one stack.
# to move, pick a tower and shift off the front. unshift onto target tower.
# can't stack a larger disk on top of a smaller one.

# won if all disks are on a single other stack.
