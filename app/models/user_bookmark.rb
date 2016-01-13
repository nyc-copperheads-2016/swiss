class UserBookmark < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  belongs_to :bookmark
  belongs_to :folder

  has_many :snippits
  has_many :user_bookmark_categories
  has_many :categories, through: :user_bookmark_categories

  accepts_nested_attributes_for :bookmark

  validates_presence_of :user, :bookmark, :name
end
