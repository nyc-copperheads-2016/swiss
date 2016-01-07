class UserBookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark

  validates_presence_of :user, :bookmark
  # set name to page title if no name is specified
end
