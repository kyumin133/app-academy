# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  user_id    :integer          not null
#  private    :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :name, :user, presence: true
  validates :private, inclusion: { in: [ true, false ] }

  belongs_to :user

  has_many :comments, as: :commentable
end
