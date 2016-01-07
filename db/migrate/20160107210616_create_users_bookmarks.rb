class CreateUsersBookmarks < ActiveRecord::Migration
  def change
    create_table :users_bookmarks do |t|
      t.references :user, null: false
      t.referneces :bookmark, null: false
      t.string :name

      t.timestamps null: false
    end
  end
end
