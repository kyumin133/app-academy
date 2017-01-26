def bsearch(array, target)
  middle_index = array.length / 2
  return nil if array.empty?
  return middle_index if array[middle_index] == target

  if array[middle_index] > target
    bsearch(array[0...middle_index], target)
  else    
    search = bsearch(array[(middle_index + 1)..-1], target)
    unless search.nil?
      return middle_index + 1 + search
    end
    return nil
  end
end

# left side
p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2

# right side
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5

# not in array
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
