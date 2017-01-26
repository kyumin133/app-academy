def subsets(array)
  return [] if array.length == 0
  return [[], [array[0]]] if array.length == 1
  new_array = []
  last_entry = array.pop
  subsets_without_last = subsets(array)
  subsets_without_last.each do |el|
    new_el = el.dup
    new_el << last_entry
    if new_array.include?(el) == false
      new_array << el
    end
    if new_array.include?(new_el) == false
      new_array << new_el
    end
  end
  new_array
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
