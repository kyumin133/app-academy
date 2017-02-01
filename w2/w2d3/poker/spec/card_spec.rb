require "card"

describe Card do
  subject(:card) { Card.new(:spade, 1) }
  describe "#initialize" do

    it "has a suit" do
      expect(card.suit).to eq(:spade)
    end

    it "has an integer value between 1 and 13" do
      expect(card.value).to eq(1)
    end

    it "shows the correct face value" do
      expect(card.face).to eq("A")
    end
  end

  describe "#to_s" do

    it "displays the face value and suit" do
      expect(card.to_s).to eq("A\u2660")
    end


  end


end
