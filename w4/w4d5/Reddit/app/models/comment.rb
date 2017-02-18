# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true
  belongs_to :post

  belongs_to :parent_comment,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :child_comments,
    dependent: :destroy,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
end
