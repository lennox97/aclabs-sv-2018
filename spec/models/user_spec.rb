require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should validate the name' do
  	user = User.new
  	expect(user.valid?).to be false
  	expect(user.errors[:name]).to eq ["can't be blank"]
  end

  it 'should validate the uniqueness of the name' do
  	user1 = User.new(name:"Daniel", password:"test");
  	
  	user1.save
  	puts user1.valid?

  	user2 = User.new(name:"Daniel", password:"test2");

  	user2.valid?
  	expect(user2.errors[:name]).to eq ["has already been taken"]
  end
end
