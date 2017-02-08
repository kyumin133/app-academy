require "rspec"
require "users"

describe User do

  context "class methods" do
    describe "::find_by_name" do
      it "finds a user by fname and lname" do
        expect(User.find_by_name("Ayn", "Rand").first.class).to eq User
      end

      it "returns nil for a user that doesn't exist" do
        expect(User.find_by_name("Ernest", "Hemingway")).to eq nil
      end
    end

    describe "::initialize" do
      subject(:grrm) { User.new('id' => 7, 'fname' => 'George', 'lname' => 'Martin') }

      it "sets an id if passed one" do
        expect(grrm.id).to eq(7)
      end

      it "sets an fname" do
        expect(grrm.fname).to eq('George')
      end

      it "sets an lname" do
        expect(grrm.lname).to eq('Martin')
      end
    end
  end

  subject(:clarissa) { User.find_by_name("Clarissa", "Dalloway")[0] }

  context "instance methods" do
    describe "#authored_questions" do
      it "retrieves all questions created by the user" do
        expect(clarissa.authored_questions.first.title).to eq('To be')
      end
    end

    describe "#authored_replies" do
      it "retrieves all replies created by the user" do
        expect(clarissa.authored_replies.first.body).to eq('Poe wrote on them.')
      end
    end

    describe "#followed_questions" do
      it "retrieves all questions followed by the user" do
        expect(clarissa.followed_questions.first.title).to eq('To be')
      end
    end

    describe "#liked_questions" do
      it "retrieves all questions liked by the user" do
        expect(clarissa.liked_questions.first.title).to eq('Why')
      end
    end

    describe "#average_karma" do
      it "calculates the user's average karma" do
        expect(clarissa.average_karma).to eq(3.0)
      end
    end
  end
end
