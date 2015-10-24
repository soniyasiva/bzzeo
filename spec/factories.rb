FactoryGirl.define do

  factory :profile_tag do
    profile
    tag
  end

  factory :tag do
    sequence(:name) { |n| "Broker#{n}" }
  end

  factory :profile do
    name "First Exit Media"
    video "https://www.youtube.com/watch?v=-9dAhOsyXBk"
    representitive "Zach Levy"
    phone "647 667 5215"
    status "Coding until dawn"
    facebook "zacharyaaronlevy"
    twitter "@zachary_levy"
    instagram "zachary_levy"
    category
    user
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    # confirmed_at Date.today
  end

  factory :category do
    sequence(:name) { |n| "Real Estate#{n}" }
  end
end
