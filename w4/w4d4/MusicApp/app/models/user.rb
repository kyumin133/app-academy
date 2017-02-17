# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activated        :boolean          default("false"), not null
#  activation_token :string           not null
#  admin            :boolean          default("false"), not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :activation_token, presence: true
  validates :email, uniqueness: true
  after_initialize :ensure_session_token
  after_initialize :ensure_activation_token
  after_initialize :ensure_activated
  has_many :notes, dependent: :destroy

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    u = User.find_by(email: email)
    if u && u.is_password?(password)
      return u
    end
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_token
  end

  def ensure_activation_token
    self.activation_token ||= User.generate_token
  end

  def ensure_activated
    self.activated ||= false
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
