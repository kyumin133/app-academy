require "byebug"
def my_min_one(arr)
  (0...arr.length).each do |i|
    is_min = true
    ((i + 1)...arr.length).each do |j|
      if arr[i] > arr[j]
        is_min = false
        break
      end
    end
    return arr[i] if is_min
  end
end

def my_min_two(arr)
  min = arr.first
  (0...arr.length).each do |i|
    min = min < arr[i] ? min : arr[i]
  end
  min
end

def largest_contiguous_subsum_one(arr)
  subsets = []

  (0...arr.length).each do |i|
    (i...arr.length).each do |j|
      subsets << arr[i..j]
    end
  end

  max_sum = arr.first
  subsets.each do |subset|
    subset_sum = subset.reduce(:+)
    max_sum = subset_sum if max_sum < subset_sum
  end
  max_sum
end

def largest_contiguous_subsum_two(arr)
  sum = arr.reduce(:+) # O(n)

  max_sum = sum # O(1)
  curr_sum = sum
  left_pointer = 0
  right_pointer = arr.length - 1

  until left_pointer >= right_pointer
    sum_without_left = curr_sum - arr[left_pointer]
    sum_without_right = curr_sum - arr[right_pointer]

    if sum_without_left > sum_without_right
      left_pointer += 1
      curr_sum = sum_without_left
    else
      right_pointer -= 1
      curr_sum = sum_without_right
    end

    max_sum = curr_sum if max_sum < curr_sum
  end


  #overall time complexity: O(n)
  max_sum
end

if __FILE__ == $PROGRAM_NAME
  list1 = [5,3,-7]
  list2 = [2,3,-6,7,-6,7,-8]
  list3 = [-5,-1,-3]

p  largest_contiguous_subsum_two(list1)
p  largest_contiguous_subsum_two(list2)
p  largest_contiguous_subsum_two(list3)
end
