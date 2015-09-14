require 'rails_helper'

RSpec.describe Sprint, type: :model do
  it {is_expected.to have_fields(:name, :goal)}
  it {is_expected.to have_field(:index).of_type(Integer)}
  it {is_expected.to have_field(:start_date).of_type(DateTime)}
  it {is_expected.to have_field(:end_date).of_type(DateTime)}
  it {is_expected.to have_field(:current).with_default_value_of(false)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_presence_of(:index)}
  it {is_expected.to validate_presence_of(:start_date)}
  it {is_expected.to validate_presence_of(:end_date)}
  it {is_expected.to belong_to(:project)}
end
