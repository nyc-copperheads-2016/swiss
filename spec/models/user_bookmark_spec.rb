require 'rails_helper'

RSpec.describe UserBookmark, type: :model do
  it { should validate_presence_of(:user)}
  it { should validate_presence_of(:bookmark)}
  it { should validate_presence_of(:name)}
  it { should belong_to(:bookmark)}
  it { should belong_to(:user)}
  it { should belong_to(:folder)}
  it { should have_many(:user_bookmark_categories)}
  it { should have_many(:snippits)}
  it { should have_many(:categories).through(:user_bookmark_categories)}
  it { should accept_nested_attributes_for (:bookmark)}
end
