require 'open-uri'

class Bookmark < ActiveRecord::Base
  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks
  validates :url, :presence => true, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }

  # validates :url, format: { with: URI.regexp }, if: Proc.new { |a| a.url.present? }
  validates_presence_of :url
  validates_uniqueness_of :url

  fuzzily_searchable :content

  def raw_content
    Nokogiri::HTML(open("#{self.url}"))
  end

  def content
    ApplicationHelper.clean(raw_content.text)
  end

  def content_changed?
    url_changed?
  end
end

