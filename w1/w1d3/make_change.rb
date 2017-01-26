def greedy_make_change(amount, coins)
  new_array = []
  coins_sorted = coins.sort.reverse
  return [] if amount == 0
  return nil if amount < coins_sorted.last
  remainder = -1
  for i in 0...coins_sorted.length do
    if amount >= coins_sorted[i]
      num_coins = amount / coins_sorted[i]
      num_coins.times { new_array << coins_sorted[i] }
      remainder = amount - (num_coins * coins_sorted[i])
      break
    end
  end
  new_array.concat(greedy_make_change(remainder, coins))
  new_array
end

p greedy_make_change(24, [10,7,1])

def make_better_change(amount, coins)
  # new_array = []
  coins_sorted = coins.sort.reverse
  return [] if amount == 0
  return nil if amount < coins_sorted.last
  best_change = []
  for i in 0...coins_sorted.length do
    if amount >= coins_sorted[i]
      remainder = amount - coins_sorted[i]
      make_remainder = make_better_change(remainder, coins)
      if best_change.length == 0 || make_remainder.length < best_change.length
        best_change = [coins_sorted[i]] + make_remainder
      end
    end
  end
  p best_change
  best_change
  # new_array.concat(make_better_change(remainder, coins))
  # new_array
end

p make_better_change(24, [10,7,1])
