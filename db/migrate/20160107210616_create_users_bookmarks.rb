class CreateUsersBookmarks < ActiveRecord::Migration
  def change
    create_table :user_bookmarks do |t|
      t.references :user, null: false
      t.references :bookmark, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
