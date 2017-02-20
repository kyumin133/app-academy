class Goal < ActiveRecord::Base
  validates :name, :user, presence: true
  validates :private, inclusion: { in: [ true, false ] }

  belongs_to :user

end
