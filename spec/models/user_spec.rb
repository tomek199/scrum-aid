require 'rails_helper'

describe User do
  it {is_expected.to have_fields(:username, :email, :encrypted_password)}
  it {is_expected.to have_and_belong_to_many(:projects)}
  it {is_expected.to have_many(:project_users)}
end