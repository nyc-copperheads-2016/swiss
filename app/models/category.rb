class Category < ActiveRecord::Base
  has_many :user_bookmark_categories
  before_create :capitalize_words

  validates_presence_of :name
  validates_uniqueness_of :name

  def capitalize_words
    name.split(" ").map {|name| name.capitalize!}
  end
  
end
