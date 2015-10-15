require 'rails_helper'

RSpec.describe ClassicRetrospective, type: :model do
  it {is_expected.to have_field(:name)}
  it {is_expected.to have_field(:date).of_type(Date)}
  it {is_expected.to have_field(:pluses).of_type(Array)}
  it {is_expected.to have_field(:minuses).of_type(Array)}
  it {is_expected.to have_field(:ideas).of_type(Array)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to belong_to(:sprint)}
end
