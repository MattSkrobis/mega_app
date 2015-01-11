FactoryGirl.define do
  factory :comment do
    sequence(:description) { |n| "description_#{n}" }
    sequence(:rating) { rand(1..10) }
    sequence(:book) {create(:book)}
    sequence(:user) {create(:user)}
  end
end
