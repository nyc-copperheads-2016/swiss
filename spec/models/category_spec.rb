require 'rails_helper'

RSpec.describe Category, type: :model do

  it { should validate_presence_of(:name) }
  it { should have_many(:user_bookmark_categories)}

  it "is invalid without a unique, case-sensitive name" do
    bookmark = Category.create(name: "jon")
    bookmark2 = Category.create(name: "Jon")
    expect(bookmark2).to be_valid
  end
end
