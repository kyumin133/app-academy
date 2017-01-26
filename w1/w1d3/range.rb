def range(start, end_point)
  return [] if end_point < start
  return [end_point] if end_point == start
  array = [start] + range(start + 1, end_point)
end

p range(3,7)
p range(3,3)
p range(3,2)

def array_sum(array)
  if array.length < 1
    return 0
  elsif array.length == 1
    return array[0]
  end
  last_entry = array.pop
  last_entry + array_sum(array)
end

def array_sum_iterative(array)
  sum = 0
  for i in 0...array.length do
    sum += array[i]
  end
  sum
end

p array_sum([1,2,3,4])
p array_sum([5,5,5,5])
p array_sum([])
p array_sum_iterative([1,2,3,4])
p array_sum_iterative([5,5,5,5])
p array_sum_iterative([])
