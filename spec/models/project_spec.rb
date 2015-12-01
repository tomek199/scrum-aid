require 'rails_helper'

RSpec.describe Project, type: :model do
  it {is_expected.to have_fields(:name, :description, :owner_id)}
  it {is_expected.to have_field(:sprint_length).of_type(Integer).with_default_value_of(14)}
  it {is_expected.to have_and_belong_to_many(:users)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_presence_of(:owner_id)}
  it {is_expected.to validate_presence_of(:owner_username)}
  it {is_expected.to validate_presence_of(:sprint_length)}
  it {is_expected.to have_many(:roles)}
  it {is_expected.to have_many(:user_roles)}
  it {is_expected.to have_many(:sprints)}
  it {is_expected.to have_many(:notebooks)}
  it {is_expected.to have_many(:events)}
  it {is_expected.to have_many(:stories)}
end
