class Email < ActionMailer::Base
  default from: "from@example.com"
  
  def password_changed(user)
    @user = user
    mail(to: @user.email, subject: "Password Has Been Changed")
  end
  
  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Password Reset")
  end
  
end
