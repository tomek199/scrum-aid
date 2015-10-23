FactoryGirl.define do
  factory :classic_retrospective do
    name {Faker::Company.buzzword}
    date {Faker::Date.backward(7)}
    pluses [Faker::Lorem.sentence, Faker::Lorem.sentence, Faker::Lorem.sentence]
    minuses [Faker::Lorem.sentence, Faker::Lorem.sentence, Faker::Lorem.sentence]
  end
end
