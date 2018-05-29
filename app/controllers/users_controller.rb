class UsersController < ApplicationController
	def new 
		@user = User.new
	end
	
	def create
		user = User.new (user_params)

		if user.save	
			#if register completed succesfully then save the session and create an amount of $100 for the user
			#amount = Amount.create(quantity: 100, user_id: user.id,currency_id: Currency.find_by(default: true).id)
			session[:user_id] = user.id
			redirect_to '/welcome'
		else
			redirect_to '/signup', alert: "Invalid name/password combination"
		end

			
	end

	def user_params
		params.require(:user).permit(:name, :password, :password_confirmation)
	end
end