class AddContentToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :content, :text
  end
end
