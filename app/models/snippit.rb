class Snippit < ActiveRecord::Base
  belongs_to :user_bookmark

  validates_presence_of :name, :content, :user_bookmark
end