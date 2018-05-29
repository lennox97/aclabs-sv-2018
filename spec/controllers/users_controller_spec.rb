require 'rails_helper'

RSpec.describe UsersController, type: :controller do

it 'should not create a user' do
	post :create, params: {user:{name:'name'}}
	expect(response.status).to eq 302
	expect(response).to redirect_to('/signup')
	expect(User.count).to eq 0
end

it 'should create a user' do
	post :create, params: {user:{name:'name', password:'password'}}
	expect(response.status).to eq 302
	expect(response).to redirect_to('/welcome')
	expect(User.count).to eq 1
end
end
