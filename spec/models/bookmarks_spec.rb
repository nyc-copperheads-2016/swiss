RSpec.describe Bookmark, type: :model do
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:url)}
  it { should have_many{:users}.through{:users_bookmarks}}
  it { should have_many{:users_bookmarks}}
end
