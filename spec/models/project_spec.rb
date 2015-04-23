require 'rails_helper'

RSpec.describe Project, type: :model do
  it {is_expected.to have_fields(:name, :description, :owner_id)}
  it {is_expected.to have_and_belong_to_many(:users)}
  it {is_expected.to validate_presence_of(:name)}
end
