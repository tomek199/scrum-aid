require 'rails_helper'

RSpec.describe Project, type: :model do
  it {is_expected.to have_fields(:name, :description)}
  it {is_expected.to have_and_belong_to_many(:users)}
end
