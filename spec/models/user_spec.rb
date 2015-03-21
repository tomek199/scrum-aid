require 'rails_helper'

describe User do

  before(:each) do
    @attr = {
        email: "test@mail.com",
        password: "password123",
        password_confirmation: "password123"
    }
  end

  it "should create new User instance" do
    User.create! @attr
  end

  it "should return User instance" do
    User.where(email: @attr[:email]).count.should == 1
  end
end