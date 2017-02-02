require "deck"
class Hand
  attr_accessor :cards
  def initialize(deck, cards = nil)
    @deck = deck

    if cards.nil?
      @cards = []
      5.times { @cards << @deck.draw }
    else
      @cards = cards
    end

    @cards.sort_by! { |card| card.value }
  end

  def evaluate
    return :straight_flush if straight_flush?
    return :four_of_kind if four_of_kind?
    return :full_house if full_house?
    return :flush if flush?
    return :straight if straight?
    return :three_of_kind if three_of_kind?
    return :two_pair if two_pair?
    return :pair if pair?
    return :high_card
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_kind?
    cards.any? do |card|
      val = card.value
      arr = cards.select { |card| card.value == val }
      arr.length == 4
    end
  end

  def full_house?
    three_of_kind? && pair?
  end

  def flush?
    suit = cards[0].suit
    cards.all? { |card| card.suit == suit }
  end

  def straight?
    values_array = []
    cards.each { |card| values_array << card.value }
    return true if values_array == [1, 10, 11, 12, 13]
    (0...4).each do |idx|
      return false if values_array[idx] + 1 != values_array[idx + 1]
    end
    true
  end

  def three_of_kind?
    cards.any? do |card|
      val = card.value
      arr = cards.select { |card| card.value == val }
      arr.length == 3
    end
  end

  def two_pair?
    values_array = []
    cards.each { |card| values_array << card.value }
    values_array.uniq!
    values_array.length == 3
  end

  def pair?
    cards.any? do |card|
      val = card.value
      arr = cards.select { |card| card.value == val }
      arr.length == 2
    end
  end

  #TODO: which beats which

end
