class UserBookmarkCategory < ActiveRecord::Base
  belongs_to :user_bookmark
  belongs_to :category

  validates_presence_of :user_bookmark, :category
end
