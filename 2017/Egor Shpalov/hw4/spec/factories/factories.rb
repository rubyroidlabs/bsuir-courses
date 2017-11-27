FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "123456"
    password_confirmation "123456"
  end

  factory :advert do |n|
    title "BitBonstick"
    content "bla bla bla"
    user
  end
end
