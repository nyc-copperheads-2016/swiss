class AddFileToUser < ActiveRecord::Migration
  def change
  	add_attachment :users, :bookmark_file
  end
end
