class User < ActiveRecord::Base
  has_secure_password
  has_many :user_bookmarks
  has_many :bookmarks , through: :user_bookmarks
  has_many :user_bookmark_categories, through: :user_bookmarks
  has_many :categories, through: :user_bookmark_categories
  has_many :folders
  validates_presence_of :first_name, :last_name, :username, :password, :email
  validates_uniqueness_of :username, :email
  validates :username, length: { minimum: 3 }
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true

  has_attached_file :bookmark_file
  validates_attachment_content_type :bookmark_file, content_type:["text/html"]
  around_update :spit_out_bookmarks
  private

  def spit_out_bookmarks
    doc = Bookmarks::Document.new
    doc.parse(self.bookmark_file.queued_for_write[:original].path)

    yield

    doc.bookmarks.each do |node|
      bookmark = Bookmark.find_or_create_by(url: node.url)
      root = Folder.find_by(name: self.username)

      if node.tags.nil?
        UserBookmark.where({name: node.title, bookmark: bookmark, user: self, folder: root}).first_or_create
      else
        node.tags.split(/\b,\b/).each_with_index do |fold, index|
          if index == 0
            @target = root.children.where({name: fold, user: self}).first_or_create
          else
            @target = @target.children.where({name: fold, user: self}).first_or_create
          end
        end
        UserBookmark.where({name: node.title, bookmark: bookmark, user: self, folder: @target}).first_or_create
      end
    end
  end
end
