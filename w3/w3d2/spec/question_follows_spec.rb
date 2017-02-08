require "rspec"
require "question_follows"

describe QuestionFollow do

  describe "::followers_for_question_id" do
    it "gets the users following a given question" do
      followers = QuestionFollow.followers_for_question_id(1)
      expect(followers.length).to eq(1)
      expect(followers.first.fname).to eq("Bartholomew")
    end
  end

  describe "::followed_questions_for_user_id" do
    it "gets the questions that a user is following" do
      questions = QuestionFollow.followed_questions_for_user_id(1)
      expect(questions.length).to eq(1)
      expect(questions.first.title).to eq("Why")
    end
  end

  describe "::most_followed_questions" do
    it "gets the 3 most followed questions" do
      questions = QuestionFollow.most_followed_questions(3)
      expect(questions.length).to eq(3)
      expect(questions.first.title).to eq("Who")
    end
  end

  describe "#initialize" do
    subject(:qf) { QuestionFollow.new('id' => 37, 'user_id' => 123, 'question_id' => -4) }

    it "sets an id" do
      expect(qf.id).to eq(37)
    end

    it "sets a user id" do
      expect(qf.user_id).to eq(123)
    end

    it "sets a question id" do
      expect(qf.question_id).to eq(-4)
    end
  end
end
