FactoryGirl.define do
  factory :next_command, class: "Bot::NextCommand" do
    name "123"
    method "asd"

    # association :next_command, factory: :next_command, strategy: :build_stub
  end
end
