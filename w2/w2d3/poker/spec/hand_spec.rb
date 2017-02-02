require "hand"
describe Hand do

  describe "#initialize" do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new(deck) }

    it "creates an array of five cards" do
      expect(hand.cards.length).to eq(5)
      expect(hand.cards.all? { |card| card.is_a?(Card) }).to be true
    end

    it "sorts hand by value" do
      expect(hand.cards).to eq(hand.cards.sort_by { |card| card.value })
    end
  end

  describe "#evaluate" do
    let(:suits) { [:spade, :diamond, :club, :heart] }
    # it "returns the highest value hand"

    it "finds straight flush" do
      cards = []
      (10..13).each { |v| cards << Card.new(:spade, v) }
      cards << Card.new(:spade, 1)
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:straight_flush)
    end

    it "finds four of a kind" do
      cards = []
      suits.each { |suit| cards << Card.new(suit, 10) }
      cards << Card.new(:spade, 12)
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:four_of_kind)
    end

    it "finds full house" do
      cards = []
      suits.shuffle.take(3).each { |suit| cards << Card.new(suit, 9) }
      suits.shuffle.take(2).each { |suit| cards << Card.new(suit, 8) }
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:full_house)
    end

    it "finds flush" do
      cards = []
      values = (1..13).to_a.shuffle.take(5)
      values.each { |val| cards << Card.new(:diamond, val) }
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:flush)
    end

    it "finds straight" do
      cards = []
      (2..6).each { |val| cards << Card.new(suits.shift, val) }
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:straight)
    end

    it "finds three of a kind" do
      cards = []
      suits.shuffle.take(3).each { |suit| cards << Card.new(suit, 7) }
      cards << Card.new(:spade, 3)
      cards << Card.new(:diamond, 12)
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:three_of_kind)
    end

    it "finds two pair" do
      cards = []
      suits.shuffle.take(2).each { |suit| cards << Card.new(suit, 6) }
      suits.shuffle.take(2).each { |suit| cards << Card.new(suit, 4) }
      cards << Card.new(:spade, 2)
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:two_pair)
    end

    it "finds one pair" do
      cards = []
      suits.shuffle.take(2).each { |suit| cards << Card.new(suit, 5) }
      cards << Card.new(:spade, 8)
      cards << Card.new(:diamond, 12)
      cards << Card.new(:heart, 7)
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:pair)
    end

    it "returns high card" do
      cards = []
      cards << Card.new(:spade, 2)
      cards << Card.new(:diamond, 4)
      cards << Card.new(:heart, 6)
      cards << Card.new(:club, 8)
      cards << Card.new(:spade, 10)
      hand = Hand.new(nil, cards)
      expect(hand.evaluate).to eq(:high_card)
    end

  end

  #TODO: which beats which
end
