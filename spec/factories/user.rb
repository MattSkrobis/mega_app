FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "first_name_#{n}" }
    sequence(:last_name) { |n| "last_name_#{n}" }
    sequence(:nickname) { |n| "nickname_#{n}" }
    sequence(:age) { |n| n }
    sequence(:country) { |n| "country_#{n}" }
    sequence(:email) { |n| "email#{n}@me.com" }
    sequence(:password) { 'secret' }
    sequence(:password_confirmation) { 'secret' }
  end
end
