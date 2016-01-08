require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presense_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_length_of(:username).is_at_least(3) }
  it { should have_many(:bookmarks).through(:user_bookmarks) }
  it { should have_many(:categories).through(:user_bookmarks_categories) }

  it "is invalid without a username" do
    user = User.new(username: nil, password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user = User.new(username: "username", password_digest: nil)
    expect(user).not_to be_valid
  end

end