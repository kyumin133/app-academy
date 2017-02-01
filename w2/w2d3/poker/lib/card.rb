class Card
  attr_reader :suit, :value, :face
  VALUES = { 1 => "A", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7",
             8 => "8", 9 => "9", 10 => "10", 11 => "J", 12 => "Q", 13 => "K" }
  SUITS = { :spade => "\u2660", :heart => "\u2661", :diamond => "\u2662", :club => "\u2663" }

  def initialize(suit, value)
    @suit = suit
    @value = value
    @face = VALUES[@value]
  end

  def to_s
    "#{@face}#{SUITS[@suit]}"
  end

end
