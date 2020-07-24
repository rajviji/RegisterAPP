class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/users/account_activation?id='+ user.id.to_s
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
