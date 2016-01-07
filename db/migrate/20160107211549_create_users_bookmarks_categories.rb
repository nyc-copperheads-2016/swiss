class CreateUsersBookmarksCategories < ActiveRecord::Migration
  def change
    create_table :user_bookmark_categories do |t|
      t.references :user_bookmark, null: false
      t.references :category, null: false

      t.timestamps null: false
    end
  end
end
