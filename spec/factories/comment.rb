FactoryGirl.define do
  factory :comment do
    sequence(:description) { |n| "description_#{n}" }
    sequence(:rating) { rand(1..10) }
    user_id { create(:user).id }
    book_id { create(:book).id }
  end
end
