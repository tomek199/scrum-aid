require 'rails_helper'

RSpec.describe Project, type: :model do
  it {is_expected.to have_fields(:name, :description, :owner_id)}
  it {is_expected.to have_and_belong_to_many(:users)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_presence_of(:owner_id)}
  it {is_expected.to validate_presence_of(:owner_username)}
  it {is_expected.to have_many(:roles)}
  it {is_expected.to have_many(:user_roles)}
  it {is_expected.to have_many(:sprints)}
end
