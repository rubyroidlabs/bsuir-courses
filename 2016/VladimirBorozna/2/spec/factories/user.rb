FactoryGirl.define do
  factory :user, class: "Bot::User" do
    telegram_id 293_410_157

    association :next_command, factory: :next_command, strategy: :create
  end
end
