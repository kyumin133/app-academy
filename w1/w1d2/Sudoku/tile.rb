require 'colorize'

class Tile
  attr_accessor :value
  attr_reader :is_given
  def initialize(value)
    @value = value
    @is_given = (@value != 0)
  end

  def to_s
    if @value == 0
      return "."
    elsif @is_given
      return @value.to_s.colorize(:blue)
    else
      return @value.to_s
    end
  end

end
