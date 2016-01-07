FactoryGirl.define do
  factory :user_bookmark_category do
    association :category, factory: :category
    association :user_bookmark, factory: :user_bookmark
  end

end
