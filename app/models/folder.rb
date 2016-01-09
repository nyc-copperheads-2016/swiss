class Folder < ActiveRecord::Base
  has_ancestry
  has_many :user_bookmark_categories
end