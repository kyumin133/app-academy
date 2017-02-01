require "deck"

describe Deck do
  subject(:deck) { Deck.new }
  describe "#initialize" do

    it "creates an array of cards" do
      expect(deck.cards).to be_a(Array)
    end

    it "has 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "has one of each kind of card" do
      expect(deck.cards).to eq(deck.cards.uniq)
    end

    it "only contains hearts, clubs, spades, and diamonds" do
      suits = [:heart, :club, :spade, :diamond]
      only_suits = deck.cards.all? { |card| suits.include?(card.suit) }
      expect(only_suits).to be true
    end

    it "only contains values between 1 and 13" do
      values = (1..13).to_a
      only_values = deck.cards.all? { |card| values.include?(card.value) }
      expect(only_values).to be true
    end

  end

  describe "#shuffle" do
    # let(:old_cards) { deck.cards.dup }
    # before(:each) { deck.shuffle }

    it "shuffles the array of cards" do
      old_cards = deck.cards.dup
      deck.shuffle
      expect(old_cards).not_to eq(deck.cards)
    end

    it "does not add or delete any cards" do
      old_cards = deck.cards.dup
      deck.shuffle
      expect(old_cards).to match_array(deck.cards)
    end
  end

  describe "#draw"


end
