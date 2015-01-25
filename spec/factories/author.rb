FactoryGirl.define do
  factory :author do
    sequence(:first_name) { |n| "first_name_#{n}" }
    sequence(:last_name) { |n| "last_name_#{n}" }
    sequence(:country) { |n| "country_#{n}" }
    sequence(:age) { |n| n }
  end
end
