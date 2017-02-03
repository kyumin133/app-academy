require_relative "stacks_queues"
def windowed_max_range(arr,window_size)
  max_range = 0

  return nil if window_size > arr.length

  for i in 0..(arr.length - window_size) do
    window = arr[i...(i + window_size)]
    window_max = window.max
    window_min = window.min

    window_range = window_max - window_min
    if window_range > max_range
      max_range = window_range
    end
  end

  max_range
end

def windowed_max_range_optimized(arr,window_size)
  return nil if window_size > arr.length

  window = MinMaxStackQueue.new

  (0...window_size).each do |i| # O(n)
    window.enqueue(arr[i])
  end

  max = window.max
  min = window.min
  max_range = max - min


  (window_size...arr.length).each do |i| # O(n)
    window.enqueue(arr[i])
    window.dequeue

    max = window.max
    min = window.min
    range = max - min
    max_range = range if max_range < range
  end

  max_range
end

if __FILE__ == $PROGRAM_NAME
 p windowed_max_range_optimized([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
 p windowed_max_range_optimized([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
 p windowed_max_range_optimized([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
 p windowed_max_range_optimized([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
 end
