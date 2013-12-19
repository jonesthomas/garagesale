class UserMailer < ActionMailer::Base
  default from: "metarepublicinc@gmail.com"

 
  def welcome_email(user)
    @user = user
    @url  = 'https://limitless-springs-8453.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to Eudora')
  end

end
