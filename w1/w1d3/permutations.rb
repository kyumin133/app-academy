def permutations(array)
  return [array] if array.length <= 1
  new_array = []
  array.each do |el|
    perm = [el]
    remainder = array - perm
    remainder_perm = permutations(remainder)
    remainder_perm.each do |rem|
      new_array << perm + rem
    end
  end
  new_array
end

p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 2, 1], [3, 1, 2]]
