require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should have_many(:user_bookmarks) }
  it { should have_many(:bookmarks).through(:user_bookmarks) }
  it { should belong_to(:user) }
end