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
  validates_attachment_content_type :bookmark_file, content_type:["text/html"]


  after_save :spit_out_bookmarks

  private

  def spit_out_bookmarks
    bookmarks = Nokogiri::HTML(Paperclip.io_adapters.for(self.bookmark_file).read)



    # bookmarks.xpath('//dt/a').each do |node|
    #   bookmark_url = node.attr('href')
    #   bookmark = Bookmark.find_or_create_by(url: bookmark_url)
    # end

    bookmarks.xpath('//dt/a').each do |node|
      bookmark_url = node.attr('href')
      bookmark = Bookmark.find_or_create_by(url: bookmark_url)
      conditions = {  name: node.text,
                      bookmark: bookmark,
                      user: self }
      UserBookmark.where(conditions).first_or_create
    end

    unable_to_save = {}
    bookmarks.xpath('//dt/a').each do |node|
      bookmark_url = node.attr('href')
      bookmark = Bookmark.find_or_initialize_by(url: bookmark_url)
      if bookmark.save
        conditions = {  name: node.text,
                      bookmark: bookmark,
                      user: self }
        UserBookmark.where(conditions).first_or_create
      else
        unable_to_save[node.text] = node.attr('href')
      end
    end

    #       b.title = node.text

    #     # Associate tags (parent folders)
    #     node.xpath('ancestor::dl').xpath('preceding-sibling::dt/h3').each do |d|
    #       tag = Library::Tag.find_by_title(d.text)
    #       if tag.nil?
    #         tag = Library::Tag.create do |t|
    #           t.title = d.text
    #         end
    #       end
    #       tag.save!
    #       bookmark.tags << tag
    #     end

    #   bookmark.save!

    # end
  end
end
