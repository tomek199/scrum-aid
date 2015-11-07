FactoryGirl.define do
  factory :notebook do
    name {Faker::Lorem.word}
    description {Faker::Lorem.sentence}
  end
end
