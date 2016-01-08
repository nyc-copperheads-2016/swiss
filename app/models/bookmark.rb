class Bookmark < ActiveRecord::Base
  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks
  validates :url, :presence => true, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }

  # validates :url, format: { with: URI.regexp }, if: Proc.new { |a| a.url.present? }
  validates_presence_of :url
  validates_uniqueness_of :url
  # validates_format_of :url, :with => URI::regexp(%w(http https))
end
