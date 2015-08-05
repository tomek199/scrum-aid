require 'rails_helper'

RSpec.describe Role, type: :model do
  it {is_expected.to have_field(:name)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to belong_to(:project)}
  it {is_expected.to have_many(:user_roles)}
end
