class Tagging < ActiveRecord::Base
  validates :tag_id, :todo_id, presence: true
  belongs_to :tag
  belongs_to :todo
end
