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
    let(:old_cards) { deck.cards.dup }

    it "shuffles the array of cards" do
      old_cards
      deck.shuffle
      expect(old_cards).not_to eq(deck.cards)
    end

    it "does not add or delete any cards" do
      old_cards
      deck.shuffle
      expect(old_cards).to match_array(deck.cards)
    end
  end

  describe "#draw" do
    it "raises an error if deck is empty" do
      deck.cards = []
      expect { deck.draw }.to raise_error("Deck is empty")
    end

    it "removes a card from the deck" do
      deck.draw
      expect(deck.cards.length).to eq(51)
    end

    it "returns the removed card" do
      old_cards = deck.cards.dup
      expect(deck.draw).to be(old_cards.pop)
    end
  end


end
