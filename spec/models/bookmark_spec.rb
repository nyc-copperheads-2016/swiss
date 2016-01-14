require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it { should have_many(:users).through(:user_bookmarks) }
  it { should have_many(:user_bookmarks) }

  it "is invalid without a url" do
    bookmark = Bookmark.new(url: nil, content: "content")
    expect(bookmark).not_to be_valid
  end

  it "is invalid without a unique url" do
    bookmark = Bookmark.create(url: "https://www.facebook.com", content: "content")
    bookmark2 = Bookmark.create(url: "https://www.facebook.com", content: "content")
    expect(bookmark2).not_to be_valid
  end

  it "is invalid without a properly formatted url" do
    bookmark2 = Bookmark.create(url: "https://www.facebook", content: "content")
    expect(bookmark2).not_to be_valid
  end
  
end
