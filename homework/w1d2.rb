def sum_to(n)
  if n <= 1
    return n
  end
  n + sum_to(n - 1)
end

def add_numbers(nums_array)
  if nums_array.length == 0
    return nil
  end
  if nums_array.length == 1
    return nums_array[0]
  end
  elem = nums_array.pop
  elem + add_numbers(nums_array)
end

def gamma_fnc(n)
  if n < 1
    return nil
  end
  if n == 1
    return 1
  end
  (n - 1) * gamma_fnc(n - 1)
end
