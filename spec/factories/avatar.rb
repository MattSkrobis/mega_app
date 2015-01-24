FactoryGirl.define do
  factory :avatar do
    sequence(:name) { |n| "name_#{n}" }
    user_id { create(:user).id }
  end
end
