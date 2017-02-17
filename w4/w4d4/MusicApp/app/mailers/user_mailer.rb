class UserMailer < ApplicationMailer
  default from: 'admin@example.com'

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/#{user.id}/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: "Activate your account for Ken's music site")
  end
end
