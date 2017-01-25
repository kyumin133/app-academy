# Authors: Kyumin (Ken) Lee and James Stack
def factors(num)
  new_array = []
  for i in 1..num do
    new_array << i if num % i == 0
  end
  new_array
end

class Array
  def bubble_sort!(&prc)
    for j in 0..self.length - 1 do
      for i in 0..self.length - 2 do
        if prc == nil
          if self[i] > self[ i + 1]
            self[i], self[i + 1] = self[i + 1], self[i]
          end
        else
          if prc.call(self[i], self[ i+1 ]) == 1
            self[i], self[ i + 1 ] = self[ i + 1], self[i]
          end
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    new_array = self.dup
    new_array.bubble_sort!(&prc)
  end
end

def substrings(string)
  substrings_array = []
  for i in 0...string.length do
    for j in 1..(string.length - i) do
      substring = string[i,j]
      if substrings_array.index(substring) == nil
        substrings_array << substring
      end
    end
  end
  substrings_array
end

def subwords(word, dictionary)
  substrings_array = substrings(word)
  new_array = substrings_array.select {|x| dictionary.index(x) != nil}
  new_array
end
