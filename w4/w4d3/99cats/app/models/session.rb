class Session < ActiveRecord::Base
  validates :session_token, uniqueness: true, allow_nil: true

  belongs_to :user
end
