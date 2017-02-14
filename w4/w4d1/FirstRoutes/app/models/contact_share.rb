class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates :contact_id, uniqueness: {scope: :user_id}

  belongs_to :sent_contact,
    primary_key: :id,
    foreign_key: :contact_id,
    class_name: :Contact

  belongs_to :receiving_user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :comments,
    as: :commentable,
    dependent: :destroy
end
