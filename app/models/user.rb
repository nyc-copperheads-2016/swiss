class User < ActiveRecord::Base
  has_secure_password
  has_many :user_bookmarks
  has_many :bookmarks , through: :user_bookmarks
  has_many :user_bookmark_categories, through: :user_bookmarks
  has_many :categories, through: :user_bookmark_categories
  validates_presence_of :first_name, :last_name, :username, :password, :email
  validates_uniqueness_of :username, :email
  validates :username, length: { minimum: 3 }
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true

  has_attached_file :bookmark_file
  validates_attachment_content_type :bookmark_file, content_type:"text/*"
end
