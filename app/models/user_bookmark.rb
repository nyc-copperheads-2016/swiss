class UserBookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark

  has_many :user_bookmark_categories
  has_many :categories, through: :user_bookmark_categories

  validates_presence_of :user, :bookmark, :name
  # set name to page title if no name is specified
end
