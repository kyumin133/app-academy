require_relative 'p05_hash_map'
require_relative 'p04_linked_list'


class LRUCache
  attr_reader :count ,:store
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # puts "Begin (#{key}): #{self}"
    node = @map[key]
    if node.nil?
      eject! if count >= @max
      val = @prc.call(key)
      # puts "prc call for #{key} returned_#{val}!!"
      node = @store.append(key , val)
      @map[key] = node
    else
      update_link!(node)
    end
    # puts "End: #{self}"
    node.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    # puts "In update: #{link}"
    @store.remove(link.key)
    @map.set(link.key,@store.append(link.key , link.val))
  end

  def eject!
    key = @store.first.key
    @map.delete(key)
    @store.remove(key)
  end
end
