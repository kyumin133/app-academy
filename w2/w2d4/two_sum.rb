require 'byebug'

# O(n^2)
def bad_two_sum?(arr, target)
  # check every single pair, return true if adds to target
  i = 0
  while i < arr.length - 1
    j = i + 1
    while j < arr.length
      sum = arr[i] + arr[j]
      return true if sum == target
      j += 1
    end
    i += 1
  end
  false
end

def okay_two_sum?(arr, target)
  sorted_arr = arr.sort

  sorted_arr.each_with_index do |el, i|
    remainder = target - el
    # debugger
    if el == remainder
      if sorted_arr.count(el) > 1
        return true
      else
        next
      end
    end

    bsearch_result = bsearch(sorted_arr, remainder)
    return true unless bsearch_result.nil?
  end
  false
end

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

def two_sum?(arr, target)

  h = Hash.new(0)

  arr.each do |key|
    h[key] += 1
  end


  h.each do |k, v|
    remainder = target - k
    # debugger
    if k == remainder
      if v > 1
        return true
      else
        next
      end
    end
    return true if h[remainder] > 0
  end
  false
end
if __FILE__ == $PROGRAM_NAME
  arr = [5, 1, 0, 7]
  # p bad_two_sum?(arr, 6)
  # p bad_two_sum?(arr, 10)
  arr2 = [3,3]
  # p okay_two_sum?(arr2,6)
  # p okay_two_sum?(arr2,7)
  # p okay_two_sum?(arr, 6)
  # p okay_two_sum?(arr, 10)
  p two_sum?(arr, 6)
  p two_sum?(arr, 10)
end
