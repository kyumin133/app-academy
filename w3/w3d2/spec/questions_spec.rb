require "rspec"
require "questions"

describe Question do

  context "class methods" do
    describe "::most_followed" do
      it "finds the 3 most followed questions" do
        result = Question.most_followed(3)
        expect(result.length).to eq(3)
        expect(result.first.title).to eq("Who")
      end
    end

    describe "::most_liked" do
      it "finds the 3 most liked questions" do
        result = Question.most_liked(3)
        expect(result.length).to eq(3)
        expect(result.first.title).to eq("To be")
      end
    end

    describe "::initialize" do
      subject(:question) { Question.new('id' => 7, 'title' => 'What', 'body' => 'day is it?', 'user_id' => 4) }

      it "sets an id if passed one" do
        expect(question.id).to eq(7)
      end

      it "sets a title" do
        expect(question.title).to eq('What')
      end

      it "sets a body" do
        expect(question.body).to eq('day is it?')
      end

      it "sets a user id" do
        expect(question.user_id).to eq(4)
      end
    end
  end

  context "instance methods" do
    subject(:question) { Question.find_by_id(1) }
    describe "#author" do
      it "finds the author of a question" do
        expect(question.author.fname).to eq("Bartholomew")
      end
    end

    describe "#replies" do
      it "finds the replies to a question" do
        expect(question.replies.length).to eq(1)
        expect(question.replies.first.body).to eq("Poe wrote on them.")
      end
    end

    describe "#followers" do
      it "finds the users following a question" do
        expect(question.followers.length).to eq(1)
        expect(question.followers.first.fname).to eq("Bartholomew")
      end
    end

    describe "#likers" do
      it "finds the users liking a question" do
        expect(question.likers.length).to eq(1)
        expect(question.likers.first.fname).to eq("Clarissa")
      end

    end

    describe "#num_likes" do
      it "finds the number of users who like a question" do
        expect(question.num_likes).to eq(1)
      end

    end
  end
end
