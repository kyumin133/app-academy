require "rspec"
require "replies"

describe Reply do
  describe "#initialize" do
    subject(:reply) { Reply.new('id' => 7, 'body' => 'It\'s Tuesday.', 'question_id' => 5, 'parent_reply_id' => 6, 'user_id' => 4) }

    it "sets an id if passed one" do
      expect(reply.id).to eq(7)
    end

    it "sets a body" do
      expect(reply.body).to eq('It\'s Tuesday.')
    end

    it "sets a question id" do
      expect(reply.question_id).to eq(5)
    end

    it "sets a parent reply id if passed one" do
      expect(reply.parent_reply_id).to eq(6)
    end

    it "sets a user id" do
      expect(reply.user_id).to eq(4)
    end
  end

  subject(:reply) { Reply.find_by_id(4) }
  describe "#author" do
    it "finds the reply's author" do
      expect(reply.author.fname).to eq("Bartholomew")
    end
  end

  describe "#question" do
    it "finds the question that it is replying to" do
      expect(reply.question.title).to eq("Who")
    end
  end

  describe "#parent_reply" do
    it "finds the parent reply if there is one" do
      expect(reply.parent_reply.body).to eq("That is the question: ")
    end
  end

  describe "#child_replies" do
    it "finds the child replies if there are any" do
      expect(reply.child_replies.first.body).to eq("The slings and arrows of outrageous fortune...")
    end
  end
end
