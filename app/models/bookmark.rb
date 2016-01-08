require 'open-uri'

class Bookmark < ActiveRecord::Base
  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks

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

