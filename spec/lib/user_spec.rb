require 'rails_helper'

describe User do
  it "First user name is John and last_name Green" do
    user = User.first
    user.name.should == "John"
    user.last_name.should == "Green"
  end
end