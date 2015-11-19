require 'rails_helper'

RSpec.describe Event, type: :model do
  it {is_expected.to have_field(:title).of_type(String)}
  it {is_expected.to have_field(:description).of_type(String)}
  it {is_expected.to have_field(:start).of_type(DateTime)}
  it {is_expected.to have_field(:end).of_type(DateTime)}
  it {is_expected.to have_field(:created_by).of_type(String)}
  it {is_expected.to have_field(:allDay).with_default_value_of(false)}
  it {is_expected.to have_field(:editable).with_default_value_of(true)}
  it {is_expected.to have_field(:color).with_default_value_of("blue")}
  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:start)}
  it {is_expected.to belong_to(:project)}
  it {is_expected.to belong_to(:user)}
end
