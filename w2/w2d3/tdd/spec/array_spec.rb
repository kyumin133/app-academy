require "array"

describe Array do
  describe "#my_uniq" do
    subject(:array) { [1, 2, 1, 3, 3] }
    it "removes duplicates and returns the result" do
      expect(array.my_uniq).to eq([1, 2, 3])
    end

    it "does not call #uniq" do
      expect(array).not_to receive(:uniq)
      array.my_uniq
    end

    context "given an empty array" do
      subject(:empty_array) { [] }
      it "returns itself" do
        expect(empty_array.my_uniq).to eq([])
      end
    end
  end

  describe "#two_sum" do
    subject(:array) { [-1, -1, 0, 0, 2, 2, -2, -2, 1, 1] }
    let(:correct_indices) { [ [0,8], [0, 9], [1, 8], [1, 9], [2, 3], [4, 6], [4, 7], [5, 6], [5, 7] ] }
    let(:result) { array.two_sum }

    #TODO: split into different test cases, run the blocks on the different test cases as relevant
    it "returns all pairs of positions where elements sum to zero" do
      expect(result).to match_array(correct_indices)
    end

    it "sorts each pair so that the smaller index comes first" do
      smaller_first = result.all? { |pair| pair[0] < pair[1] }
      expect(smaller_first).to be true
    end

    it "should not return pairs with the same index" do
      no_dups = result.all? { |pair| pair[0] != pair[1] }
      expect(no_dups).to be true
    end

    it "sorts in dictionary order" do
      expect(result).to eq(result.sort)
    end

    it "returns an empty array if there are no such pairs" do
      expect([].two_sum.empty?).to be true
    end
  end

  describe "#my_transpose" do
    subject(:rows) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:columns) { rows.transpose }

    it "does not call #transpose" do
      expect(rows).not_to receive(:transpose)
      rows.my_transpose
    end

    it "transposes the array properly" do
      expect(rows.my_transpose).to eq(columns)
    end

  end

  describe "#stock_picker" do
    subject(:prices) { [2, 4, 1, 5, 0, 3] }
    let(:best_pair) { [2, 3] }
    let(:result) { prices.stock_picker }

    it "returns an array of length two" do
      expect(result.length).to eq(2)
    end

    it "outputs the most profitable pair of days" do
      expect(result).to eq(best_pair)
    end

    it "does not try to sell stock before buying" do
      expect(result[0]).to be < result[1]
    end

    it "returns empty array if there is no profitable pair of days" do
      expect([3, 2, 1].stock_picker).to be_empty
    end

    it "raises an error if the array of days is less than two" do
      expect { [1].stock_picker }.to raise_error("Array must be at least length 2.")
    end

  end

end
