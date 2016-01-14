require 'rails_helper'

RSpec.describe Snippit, type: :model do
  it { should belong_to(:user_bookmark) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_bookmark) }
end