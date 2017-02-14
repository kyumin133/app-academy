class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :created_contacts,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Contact,
    dependent: :destroy

  has_many :contact_shares,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ContactShare,
    dependent: :destroy

  has_many :received_contacts,
    through: :contact_shares,
    source: :sent_contact

  has_many :comments, # comments on the user
    as: :commentable,
    dependent: :destroy

  has_many :written_comments, #comments that the user has written
    primary_key: :id,
    foreign_key: :commenter_id,
    class_name: :Comment
end
