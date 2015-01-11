FactoryGirl.define do
  factory :cover do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:book) { create(:book) }
  end
end
