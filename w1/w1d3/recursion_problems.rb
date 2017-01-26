#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return 0 if array.empty?
  return array.first if array.length == 1
  new_array = array.dup
  current_val = new_array.shift
  current_val += sum_recur(new_array)
end

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  # p array
  return false if array.empty?
  return array.first == target if array.length == 1
  new_array = array.dup
  current_val = new_array.shift
  return true if current_val == target
  includes?(new_array, target)
end

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  new_array = array.dup
  current_val = new_array.shift
  return 1 + num_occur(new_array, target) if current_val == target
  return num_occur(new_array, target)
end

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  # return array.reduce(:+) == 12 if array.length == 2
  new_array = array.dup
  current_val = new_array.shift
  next_val = new_array.first
  return true if current_val + next_val == 12
  add_to_twelve?(new_array)
end

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.length < 2
  new_array = array.dup
  current_val = new_array.shift
  next_val = new_array.first
  return false if current_val > next_val
  sorted?(new_array)
end

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return "" if string.length == 0
  last = string[-1]
  new_string = string[0...-1]
  last + reverse(new_string)
end
