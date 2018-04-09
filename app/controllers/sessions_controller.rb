class SessionsController < ApplicationController
def new
	redirect_to '/welcome' if current_user
end

def create
	user = User.find_by(name: params[:name])#caut userul dupa nume in bd
	if user && user.authenticate(params[:password])#daca l-am gasit si am match pe parola
		session[:user_id] = user.id #salvez sesiunea si il trimit pe home
		redirect_to '/welcome'
	else
		redirect_to '/login', alert: 'Invalid user' # eroare de logare
	end
end

def destroy			
	session[:user_id] = nil
	redirect_to '/login'
end

end