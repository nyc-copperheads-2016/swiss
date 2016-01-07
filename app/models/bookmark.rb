class Bookmark < ActiveRecord::Base
  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks

  validates_presence_of :url, :user_bookmarks
  validates_uniqueness_of :url
end
