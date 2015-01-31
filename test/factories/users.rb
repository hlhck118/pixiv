FactoryGirl.define do
  factory :user do
    email "usertest1@gmail.com"
    password "12345678"
    password_confirmation "12345678"

    factory :user_2 do
      email "usertest2@gmail.com"
    end
  end
end