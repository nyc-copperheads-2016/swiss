class DropFolderIdFromUserBookmarkCategory < ActiveRecord::Migration
  def change
  	remove_column :user_bookmark_categories, :folder_id, :integer
  	add_column :user_bookmarks, :folder_id, :integer
  end
end
