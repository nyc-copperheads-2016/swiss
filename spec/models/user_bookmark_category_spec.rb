require 'rails_helper'

RSpec.describe UserBookmarkCategory, type: :model do
  it { should belong_to(:category)}
  it { should belong_to(:user_bookmark)}
end
