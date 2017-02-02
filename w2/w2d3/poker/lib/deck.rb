require_relative "card"

class Deck
  attr_accessor :cards
  SUITS = [:spade, :heart, :diamond, :club]
  VALUES = (1..13).to_a

  def initialize
    @cards = []

    SUITS.each do |suit|
      VALUES.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def draw
    raise "Deck is empty" if @cards.empty?

    @cards.pop
  end

end
