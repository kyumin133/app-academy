def merge_sort(array)
  return [] if array.length == 0
  return array if array.length == 1
  middle_index = array.length / 2
  left_half = merge_sort(array[0...middle_index])
  right_half = merge_sort(array[middle_index...array.length])
  merge(left_half, right_half)
end

def merge(array_one, array_two)
  index_one = 0
  index_two = 0
  return array_two if array_one.length == 0
  return array_one if array_two.length == 0
  merged = []
  while index_one < array_one.length || index_two < array_two.length do
    if array_one[index_one] == nil
      merged << array_two[index_two]
      index_two += 1
      next
    elsif array_two[index_two] == nil
      merged << array_one[index_one]
      index_one += 1
      next
    end
    if array_two[index_two] < array_one[index_one]
      merged << array_two[index_two]
      index_two += 1
    else
      merged << array_one[index_one]
      index_one += 1
    end
  end
  # p merged
  merged
end

a = (0..10).to_a
a.shuffle!
p a
p merge_sort(a)
p a
