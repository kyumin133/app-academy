require "rspec"
require "model_base"
require "questions"
require "replies"

describe ModelBase do
  describe "::find_by_id" do
    it "finds questions by id" do
      expect(Question.find_by_id(4).title).to eq("To be")
    end

    it "finds replies by id" do
      expect(Reply.find_by_id(4).body).to eq("Whether tis nobler in the mind to suffer")
    end
  end

  describe "::all" do
    it "finds all questions" do
      all_questions = Question.all
      expect(all_questions.length).to eq(5)
      expect(all_questions[1].title).to eq("How high")
    end

    it "finds all replies" do
      all_replies = Reply.all
      expect(all_replies.length).to eq(5)
      expect(all_replies[1].body).to eq("42 feet.")
    end
  end

  describe "::where" do
    it "raises an error if not passed a hash or a string" do
      expect { Question.where(3) }.to raise_error("must be passed a hash or a string!")
    end

    it "finds a question when passed a query string" do
      expect(Question.where("id = 2").first.title).to eq("How high")
    end

    it "finds a question when passed a hash" do
      expect(Question.where("id" => 2).first.title).to eq("How high")
    end

    it "finds a reply when passed a query string" do
      expect(Reply.where("id = 2").first.body).to eq("42 feet.")
    end

    it "finds a reply when passed a hash" do
      expect(Reply.where("id" => 2).first.body).to eq("42 feet.")
    end

  end

  describe "::method_missing" do
    it "raises an error unless the method begins with find_by_" do
      expect { Question.asdf(1, 2) }.to raise_error("no such method")
    end

    it "raises an error if the number of arguments doesn't match the method name" do
      expect { Question.find_by_title_and_body("How high") }.to raise_error("unexpected # of arguments")
    end

    it "finds a question by title" do
      expect(Question.find_by_title("How high").first.id).to eq(2)
    end

    it "finds a reply by body" do
      expect(Reply.find_by_body("42 feet.").first.id).to eq(2)
    end
  end

  describe "#save" do
    it "saves a new question" do
      q = Question.new('title' => "How?", 'body' => 'And why?', 'user_id' => 2)
      allow_any_instance_of(QuestionDBConnection).to receive(:last_insert_row_id).and_return(7)
      allow_any_instance_of(QuestionDBConnection).to receive(:execute).and_return("test")
      expect(q.save).to eq(7)
    end

    it "updates an existing question" do
      q = Question.find_by_id(3)
      q.body = "is John Adams?"
      allow_any_instance_of(QuestionDBConnection).to receive(:execute).and_return("test")
      expect(q.save).to eq(3)
    end

    it "saves a new reply" do
      r = Reply.new('body' => 'And why?', 'question_id' => 3, 'parent_reply_id' => 4, 'user_id' => 2)
      allow_any_instance_of(QuestionDBConnection).to receive(:last_insert_row_id).and_return(7)
      allow_any_instance_of(QuestionDBConnection).to receive(:execute).and_return("test")
      expect(r.save).to eq(7)
    end

    it "updates an existing reply" do
      r = Reply.find_by_id(3)
      r.body = "is John Adams?"
      allow_any_instance_of(QuestionDBConnection).to receive(:execute).and_return("test")
      expect(r.save).to eq(3)
    end
  end
end
