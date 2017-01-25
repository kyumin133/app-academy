# Authors: Kyumin (Ken) Lee and James Stack
class Array
  def my_each(&prc)
    i = 0
    while i < self.length do
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    new_array = []
    self.my_each do |num|
      if prc.call(num)
        new_array << num
      end
    end
    new_array
  end

  def my_reject(&prc)
    new_array = []
    self.my_each do |num|
      new_array << num unless prc.call(num)
    end
    new_array
  end

  def my_any?(&prc)
    self.my_each do |num|
      return true if prc.call(num)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |num|
      return false if prc.call(num) == false
    end
    true
  end

  def my_flatten
    new_array = []
    for i in (0...self.length) do
      if self[i].is_a?(Array)
        flattened = self[i].my_flatten
        for j in (0...flattened.length) do
          new_array << flattened[j]
        end
      else
        new_array << self[i]
      end
    end
    new_array
  end

  def my_zip(*args)
    zipped_array = []
    for i in (0...self.length) do
      interior_array = []
      interior_array << self[i]
      for j in (0...args.length) do
        if i < args[j].length
          interior_array << args[j][i]
        else
          interior_array << nil
        end
      end
      zipped_array << interior_array
    end
    zipped_array
  end

  def my_rotate(shift = 1)
    new_array = Array.new(self.length)
    self.each.with_index do |x, index|
      if self[index - shift] == nil
        new_array[(index - shift) % self.length] = x
      else
        new_array[index - shift] = x
      end
    end
    new_array
  end

  def my_join(sep = "")
    new_str = ""
    self.each.with_index do |char, index|
      if index == self.length - 1
        new_str += char
      else
        new_str += char + sep
      end
    end
    new_str
  end

  def my_reverse
    new_array = []
    for i in ((self.length - 1).downto(0)) do
      new_array << self[i]
    end
    new_array
  end
end
