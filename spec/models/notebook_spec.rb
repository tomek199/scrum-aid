require 'rails_helper'

RSpec.describe Notebook, type: :model do
  it {is_expected.to have_field(:name).of_type(String)}
  it {is_expected.to have_field(:description).of_type(String)}
  it {is_expected.to have_field(:removable).with_default_value_of(true)}
  it {is_expected.to have_field(:default).with_default_value_of(false)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to belong_to(:project)}
  it {is_expected.to embed_many(:notes)}
end
