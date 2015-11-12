FactoryGirl.define do
  factory :partner do
    profile nil
    partner nil
  end

  factory :page do
    html "MyText"
    slug "MyString"
  end

  factory :conversation do
    sender nil
    receiver nil
    message "MyText"
    read false
  end

  factory :friend do
    profile nil
    friend nil
    mutual false
  end

  factory :share do
    post
    profile
  end

  factory :like do
    profile
    post
  end

  factory :comment do
    profile
    post
    description "Great content"
  end

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
      video_url "-9dAhOsyXBk"
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
    video_url "-9dAhOsyXBk"
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
