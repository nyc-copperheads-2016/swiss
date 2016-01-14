FactoryGirl.define do
  factory :user do
    username {Faker::Internet.user_name}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password "MyString"
  end

end
