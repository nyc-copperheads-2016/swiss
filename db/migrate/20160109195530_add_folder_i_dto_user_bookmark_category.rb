class AddFolderIDtoUserBookmarkCategory < ActiveRecord::Migration
  def change
    add_column :user_bookmark_categories, :folder_id, :integer
  end
end
