# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  moderator_id :integer          not null
#  title        :string           not null
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :moderator_id, :title, presence: true
  validates :title, uniqueness: true

  has_many :post_subs, dependent: :destroy
  has_many :posts,
    through: :post_subs,
    source: :post,
    dependent: :destroy

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User
end
