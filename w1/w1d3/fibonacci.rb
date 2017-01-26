def fib_r(n)
  return nil if n < 1
  return [1] if n == 1
  return [1,1] if n == 2
  array = fib_r(n - 1)
  new_element = array[array.length - 2] + array[array.length - 1]
  array << new_element
end

def fib_i(n)
  return nil if n < 1
  return [1] if n == 1
  return [1,1] if n == 2
  array = [1,1]
  for i in 3..n do
    new_element = array[array.length - 2] + array[array.length - 1]
    array << new_element
  end
  array
end

p fib_r(0)
p fib_r(1)
p fib_r(2)
p fib_r(8)

p fib_i(0)
p fib_i(1)
p fib_i(2)
p fib_i(8)
