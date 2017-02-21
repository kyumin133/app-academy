# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  comment          :text             not null
#  author_id        :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :comment, :author_id, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
  
  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
end
