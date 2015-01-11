FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "title_#{n}"}
    sequence(:author) {|n| "author_#{n}"}
    sequence(:description) {|n| "description_#{n}"}
    sequence(:publisher) {|n| "publisher_#{n}"}
    sequence(:edition) {|n| Book::EDITIONS.sample}
    sequence(:genre) {|n| "genre_#{n}"}
  end
end
