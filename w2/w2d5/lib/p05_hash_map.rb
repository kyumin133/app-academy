require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    bucket_list = bucket(key)
    if bucket_list.include?(key)
       bucket_list.update(key, val)
    else
      bucket_list.append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call link.key , link.val
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets * 2
    new_arr = Array.new(new_size) { LinkedList.new }
    each do |k, v|
      hash_value = k.hash
      remainder = hash_value % new_size
      new_arr[remainder].append(k, v)
    end
    @store = new_arr
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    num = key.hash
    remainder = num % num_buckets
    @store[remainder]
  end
end
