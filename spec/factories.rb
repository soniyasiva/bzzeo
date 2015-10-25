FactoryGirl.define do

  factory :post do
    image_url nil
    video_url nil
    description "This is a really good post description"
    profile

    trait :image do
      image_url "http://placehold.it/600x400"
      video_url nil
    end

    trait :video do
      image_url nil
      video_url "https://www.youtube.com/watch?v=-9dAhOsyXBk"
    end
  end

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
