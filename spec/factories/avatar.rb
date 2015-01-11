FactoryGirl.define do
  factory :avatar do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:user) { create(:user) }
  end
end
