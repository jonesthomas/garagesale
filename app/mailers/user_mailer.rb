class UserMailer < ActionMailer::Base
  default from: "metarepublicinc@gmail.com"


	def password_reset(user)
  	@user = user
    mail(to: @user.email, subject: 'Password Reset')
	end


 
  def welcome_email(user)
    @user = user
    @url  = 'https://limitless-springs-8453.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to Eudora')
  end

	def send_comment(message)
  	@message = message
  	email = "metarepublicinc@gmail.com"
    mail(to: email, subject: 'You have a comment from Eudora')
	end
end
