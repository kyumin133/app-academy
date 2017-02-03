# O(n!)
def first_anagram?(str1, str2)
  anagrams = str1.chars.permutation
  anagrams.include?(str2.chars)
end

# O(n^2)
def second_anagram?(str1, str2)
  arr1 = str1.chars
  arr2 = str2.chars

  arr1.delete_if do |c1|
    if arr2.include?(c1)
      arr2.delete_at(arr2.index(c1))
      true
    end
  end

  arr1.empty? && arr2.empty?
end

# O(n log n)
def third_anagram?(str1,str2)
  arr1 = str1.chars.sort
  arr2 = str2.chars.sort

  arr1 == arr2
end

def fourth_anagram?(str1,str2)
  h1 = Hash.new(0)
  h2 = Hash.new(0)

  str1.chars.each do |c1| # O(n)
    h1[c1] += 1
  end

  str2.chars.each do |c2| # O(n)
    h2[c2] += 1
  end

  h1 == h2
end


def bonus_anagram?(str1,str2)
  h = Hash.new(0)

  str1.chars.each do |c1|
    h[c1] += 1
  end

  str2.chars.each do |c2|
    return false if h[c2] == 0
    h[c2] -= 1
  end

  h.all? do |k, v|
    v == 0
  end
end

if __FILE__ == $PROGRAM_NAME
  # p first_anagram?("california", "niacalifor")
  # p second_anagram?("california", "niacalifor")
  # p second_anagram?("hills", "hill")
  # p third_anagram?("california", "niacalifor")
  # p third_anagram?("hills", "hill")
  # p fourth_anagram?("california", "niacalifor")
  # p fourth_anagram?("hills", "hill")
  p bonus_anagram?("hills", "hill")
  p bonus_anagram?("california", "niacalifor")

end
