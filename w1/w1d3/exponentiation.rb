def exp_one(num, power)
  return nil if power < 0
  if power == 0
    return 1
  end
  num * exp_one(num, power - 1)
end

# p exp_one(0, 0)
# p exp_one(5, 0)
# p exp_one(5, 3)
# p exp_one(0, 3)

def exp_two(num, power)
  return 1 if power == 0
  return num if power == 1
  if power.odd?
    exp = exp_two(num, (power - 1) / 2)
    num * exp * exp
  else
    exp = exp_two(num, power / 2)
    exp * exp
  end
end

p exp_two(2, 8) # 256
p exp_two(2, 7) # 128
p exp_two(2, 6) # 64
p exp_two(2, 5) # 32
p exp_two(2, 4)  # 16
p exp_two(2, 3)  # 8
p exp_two(2, 2)  # 4
p exp_two(2, 1)  # 2
p exp_two(2, 0)  # 1

# exp_two(2, 13) --> line 18
# 2 * exp_two(2, 12)
# 2 * exp_two(2, 6)
# 2 * exp_two(2, 3)
# 2 * exp_two(2, 2)
# 2 * exp_two(2, 1)
