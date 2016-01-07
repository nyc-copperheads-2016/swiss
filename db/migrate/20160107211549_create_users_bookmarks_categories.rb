class CreateUsersBookmarksCategories < ActiveRecord::Migration
  def change
    create_table :users_bookmarks_categories do |t|
      t.references :users_bookmark, null: false
      t.references :category, null: false

      t.timestamps null: false
    end
  end
end
