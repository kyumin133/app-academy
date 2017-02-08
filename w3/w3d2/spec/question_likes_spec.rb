require "rspec"
require "question_likes"

describe QuestionLike do

  describe "::likers_for_question_id" do
    it "gets the users who like a given question" do
      likers = QuestionLike.likers_for_question_id(4)
      expect(likers.length).to eq(3)
      expect(likers.first.fname).to eq("Charles")
    end
  end

  describe "::num_likes_for_question_id" do
    it "gets the number of likes for a given question" do
      expect(QuestionLike.num_likes_for_question_id(4)).to eq(3)
    end
  end

  describe "::liked_questions_for_user_id" do
    it "gets the questions that a user likes" do
      questions = QuestionLike.liked_questions_for_user_id(1)
      expect(questions.length).to eq(1)
      expect(questions.first.title).to eq("To be")
    end
  end

  describe "::most_liked_questions" do
    it "gets the 3 most liked questions" do
      questions = QuestionLike.most_liked_questions(3)
      expect(questions.length).to eq(3)
      expect(questions.first.title).to eq("To be")
    end
  end

  describe "#initialize" do
    subject(:ql) { QuestionLike.new('id' => 37, 'user_id' => 123, 'question_id' => -4) }

    it "sets an id" do
      expect(ql.id).to eq(37)
    end

    it "sets a user id" do
      expect(ql.user_id).to eq(123)
    end

    it "sets a question id" do
      expect(ql.question_id).to eq(-4)
    end
  end
end
