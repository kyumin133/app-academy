class Tag < ActiveRecord::Base
  validates :tag, presence: true, uniqueness: true
  has_many :taggings
  has_many :todos, through: :taggings
end
