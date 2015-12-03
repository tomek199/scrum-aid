require 'rails_helper'

RSpec.describe Story, type: :model do
  it {is_expected.to have_field(:title).of_type(String)}
  it {is_expected.to have_field(:summary).of_type(String)}
  it {is_expected.to have_field(:index).of_type(Integer)}
  it {is_expected.to have_field(:points).of_type(Float)}
  it {is_expected.to have_field(:status).of_type(String).with_default_value_of("open")}
  it {is_expected.to have_field(:created_at).of_type(DateTime)}
  it {is_expected.to have_field(:created_by).of_type(String)}
  it {is_expected.to have_field(:updated_at).of_type(DateTime)}
  it {is_expected.to have_field(:updated_by).of_type(String)}
  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:index)}
  it {is_expected.to validate_presence_of(:created_at)}
  it {is_expected.to validate_presence_of(:created_by)}  
  it {is_expected.to belong_to(:project)}
  it {is_expected.to belong_to(:sprint)}
end
