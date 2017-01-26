class Array

  def deep_dup
    duplicated = []
    self.each do |el|
      if el.is_a?(Array)
        duplicated << el.deep_dup
      else
        duplicated << el
      end
    end
    duplicated
  end

end

robot_parts = [
  ["nuts", ["bolts", "washers"]],
  ["capacitors", "resistors", "inductors"],
  "random"
]

robot_parts_copy = robot_parts.deep_dup

# shouldn't modify robot_parts
robot_parts_copy[1] << "LEDs"
# wtf?
p robot_parts # => ["capacitors", "resistors", "inductors", "LEDs"]
p robot_parts_copy
