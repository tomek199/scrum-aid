FactoryGirl.define do
  factory :sprint do
    name {Faker::Company.buzzword}
    index {Random.rand()}
    start_date {Faker::Date.forward(7)}
    end_date {Faker::Date.forward(21)}
    goal {Faker::Lorem.sentence}
  end
end
