require 'rails_helper'

RSpec.describe Note, type: :model do
  it {is_expected.to have_field(:text).of_type(String)}
  it {is_expected.to have_field(:created_at).of_type(DateTime)}
  it {is_expected.to have_field(:created_by).of_type(String)}
  it {is_expected.to validate_presence_of(:text)}
  it {is_expected.to validate_presence_of(:created_at)}
  it {is_expected.to validate_presence_of(:created_by)}
  it {is_expected.to be_embedded_in(:notebook)}
end
