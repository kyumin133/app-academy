class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    # for now, assuming that they are Fixnums
    array_copy = self.dup
    hash_value = array_copy.shift.hash
    array_copy.each_with_index do |el, i|
      if el.is_a?(String) ||  el.is_a?(Array)
        hash_value = hash_value ^ (el.hash * i.hash)
      else
        hash_value = hash_value ^ (i * el).hash
      end
    end
    hash_value
  end
end

class String
  def hash
    # chars.hash
    hash_value = chars.map { |ch| ch.ord }.hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.hash
  end
end
