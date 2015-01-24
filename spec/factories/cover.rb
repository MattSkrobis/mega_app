FactoryGirl.define do
  factory :cover do
    sequence(:name) { |n| "name_#{n}" }
    book_id { create(:book).id }
  end
end
