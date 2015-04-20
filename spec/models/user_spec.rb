require 'rails_helper'

describe User do

  before(:each) do
    @attr = {
        email: "test@mail.com",
        password: "password123",
        password_confirmation: "password123"
    }
  end

  it {is_expected.to have_and_belong_to_many(:projects)}

  it "should create new User instance" do
    User.create! @attr
  end

  it "should return User instance" do
    user = User.where(email: @attr[:email])
    expect(user.count).to eq 1
  end
end