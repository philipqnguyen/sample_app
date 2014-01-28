module SessionsHelper

	def sign_in(user)
		#You can set cookies with an optional expiration date
		#for example:
		#cookies.[:remember_token] = { value: user.remember_token,
		#															 expires: 20.years.from_now.utc }
		cookies.permanent[:remember_token] = user.remember_token
		#The purpose of the below line is to create a current_user to be
		#used on controllers and views.
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	#defining an instance variable '@current_user' for later use
	def current_user=(user)
		@current_user = user
	end

	def current_user
		#remember that || is 'or'
		#The bottom line means: 
		#@current_user = @current_user || User.find_by_remember_token(cookies[:remember_token])
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
end
