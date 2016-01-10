require 'open-uri'
require 'elasticsearch/model'

class Bookmark < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :user_bookmarks
  has_many :users, through: :user_bookmarks
  validates :url, :presence => true, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }

  validates_presence_of :url
  validates_uniqueness_of :url

  after_save :set_content
  after_find :set_content

  def raw_content
    Nokogiri::HTML(open("#{self.url}"))
  end

  def set_content
    self.content = ApplicationHelper.clean(raw_content.text.downcase)
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['url^10', 'content']
          }
        }
      }
    )
  end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :content, analyzer: 'english'
      indexes :url, analyzer: 'english'
    end
  end
end

# Delete the previous bookmarks index in Elasticsearch
Bookmark.__elasticsearch__.client.indices.delete index: Bookmark.index_name rescue nil

# Create the new index with the new mapping
Bookmark.__elasticsearch__.client.indices.create \
  index: Bookmark.index_name,
  body: { settings: Bookmark.settings.to_hash, mappings: Bookmark.mappings.to_hash }

# Index all Bookmark records from the DB to Elasticsearch
Bookmark.import