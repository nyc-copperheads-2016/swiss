class UserBookmark < ActiveRecord::Base

  belongs_to :user
  belongs_to :bookmark

  has_many :user_bookmark_categories
  has_many :categories, through: :user_bookmark_categories

  accepts_nested_attributes_for :bookmark

  validates_presence_of :user, :bookmark, :name
  # set name to page title if no name is specified
  # def separate_categories_and_save(categories, user_bookmark)
  #   categories.split(",").each do |category|
  #     category = category.downcase.gsub(/,\s+/,"")
  #     user_bookmark.categories.find_or_create_by(name: category)
  #   end
  # end

end
