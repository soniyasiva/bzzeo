FactoryGirl.define do

  factory :user do
    email "zacharyalevy@gmail.com"
    password "password"
    password_confirmation "password"
    # confirmed_at Date.today
  end

  factory :category do
    name "Real Estate"
  end
end
