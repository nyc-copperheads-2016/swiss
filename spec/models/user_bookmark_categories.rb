RSpec.describe User_Bookmark_Categories, type: :model do
  it { should belong_to{:category}
  it { should belong_to{:user_bookmark}}
end