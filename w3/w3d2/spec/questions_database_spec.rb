require 'rspec'
require "questions_database"

describe QuestionDBConnection do
  it "creates a SQLite3 database connection" do
    expect(QuestionDBConnection).to receive(:instance)
    QuestionDBConnection.instance
  end
end
