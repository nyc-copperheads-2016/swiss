class Category < ActiveRecord::Base
  has_many :user_bookmark_categories

  validates_presence_of :name
  validates_uniqueness_of :name
end
