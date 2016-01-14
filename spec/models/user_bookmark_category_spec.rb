require 'rails_helper'

RSpec.describe UserBookmarkCategory, type: :model do
  it { should belong_to(:category)}
  it { should belong_to(:user_bookmark)}
  it { should validate_presence_of(:category)}
  it { should validate_presence_of(:user_bookmark)}
end
