FactoryGirl.define do
  factory :event do
    title {Faker::Lorem.word}
    start {Faker::Time.forward(1, :morning)}
    allDay {true}
    created_by {Faker::Internet.user_name}
  end
end
