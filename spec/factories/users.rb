FactoryGirl.define do
  factory :user do
    email 'test@mail.com'
    password 'password123'
    password_confirmation 'password123'
  end
end