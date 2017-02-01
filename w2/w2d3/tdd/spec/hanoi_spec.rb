require "hanoi"

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }


  describe "#move" do
    it "takes exactly two positions" do
      expect { game.move(0) }.to raise_error(ArgumentError)
    end

    it "takes two different positions" do
      expect { game.move(0, 0) }.to raise_error("Positions must be different.")
    end

    it "takes only positions between 0 and 2" do
      expect { game.move(0, 3) }.to raise_error("Positions must be between 0 and 2.")
    end

    it "moves the first disk of the source to the first disk of the target" do
      game.move(0, 1)
      correct_move = game.tower0 == [2, 3] && game.tower1 == [1] && game.tower2 == []
      expect(correct_move).to be true
    end

    it "raises an error if a larger disk would be moved on top of a smaller disk" do
      game.tower0 = [3]
      game.tower1 = [1, 2]
      game.tower2 = []

      expect { game.move(0, 1) }.to raise_error("Larger disk cannot be moved onto smaller disk.")
    end

    it "raises an error if the source is empty" do
      expect { game.move(2, 0) }.to raise_error("Source cannot be empty.")
    end

  end

  describe "#won?" do
    # all of the disks are stacked on either position 1 or position 2
    it "returns true if all disks are stacked on either position 1 or position 2" do
      results = []
      game.tower0 = []
      game.tower1 = [1, 2, 3]
      game.tower2 = []

      results << game.won?

      game.tower0 = []
      game.tower1 = []
      game.tower2 = [1, 2, 3]

      results << game.won?

      expect(results.all? { |result| result }).to be true
    end

    it "returns false if all disks are stacked on position 0" do
      expect(game.won?).to be false
    end

    it "returns false if disks are on both positions 1 and 2" do
      game.tower0 = []
      game.tower1 = [1]
      game.tower2 = [2, 3]
      expect(game.won?).to be false
    end

  end
end
