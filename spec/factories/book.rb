FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:description) { |n| "description_#{n}" }
    sequence(:edition) {Book::EDITIONS.sample }
    sequence(:genre) { |n| "genre_#{n}" }
    publisher_id { create(:publisher).id }
    author_id { create(:author).id }
  end
end
