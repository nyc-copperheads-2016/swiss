require 'rails_helper'

RSpec.describe User do
  before(:each) do
    @user = FactoryGirl.create(:user, username: Faker::Internet.user_name(10), email: Faker::Internet.email)
  end
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_length_of(:username).is_at_least(3) }
  it { should have_many(:bookmarks).through(:user_bookmarks) }
  it { should have_many(:user_bookmark_categories).through(:user_bookmarks) }
  it { should have_many(:categories).through(:user_bookmark_categories) }

  it "is invalid without a username" do
    user = User.new(username: nil, password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user = User.new(username: "username", password_digest: nil)
    expect(user).not_to be_valid
  end

   it "is invalid without a unique email" do
    user = User.create(first_name: "jon", last_name: "valjean", username: "username", email: "jon@jon.com", password_digest: "password")
    user2 = User.create(first_name: "jon", last_name: "valjean", username: "jonvaljean", email: "jon@jon.com", password_digest: "password")
    expect(user2).not_to be_valid
  end

  it "is invalid without a unique username" do
    user = User.create(first_name: "jon", last_name: "valjean", username: "username", email: "jon@jon.com", password_digest: "password")
    user2 = User.create(first_name: "jon", last_name: "valjean", username: "username", email: "jon@jonvaljean.com", password_digest: "password")
    expect(user2).not_to be_valid
  end

end