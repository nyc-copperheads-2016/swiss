FactoryGirl.define do
  factory :user_bookmark do
    association :user, factory: :user
    association :bookmark, factory: :bookmark
    name {Faker::Internet.domain_word}
  end

end
