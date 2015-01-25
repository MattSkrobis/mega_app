FactoryGirl.define do
  factory :publisher do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:country) { |n| "country_#{n}" }
    sequence(:email) { |n| "email_#{n}" }
    sequence(:phone) { |n| "phone_#{n}" }
  end
end
