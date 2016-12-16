class UserMailer < ApplicationMailer

	def welcome_email(user)
		@user = user
		@url  = 'http://example.com/login'
		Rails.logger.debug @user.email
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end

	
end
