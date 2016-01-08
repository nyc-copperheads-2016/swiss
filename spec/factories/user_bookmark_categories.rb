FactoryGirl.define do
  factory :user_bookmark_category do
    association :category, factory: :category
  end
end