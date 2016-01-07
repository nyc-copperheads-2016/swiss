RSpec.describe User_Bookmarks, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:bookmark)}
  it { should belong_to{:user}}
  it { should have_many{:user_bookmark_categories}}
end