FactoryGirl.define do
  factory :user_to_sign_up do
    username 'Test'
    email {Faker::Internet.email}
    password 'password123'
    password_confirmation 'password123'
  end
end