FactoryGirl.define do
  factory :story do
    title {Faker::Lorem.word}
    summary {Faker::Lorem.sentence}
    created_by {Faker::Internet.user_name}
    points {2}
    index {0}
  end
end
