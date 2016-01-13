class CreateSnippits < ActiveRecord::Migration
  def change
    create_table :snippits do |t|
      t.string :name, null: false
      t.string :content, null: false
      t.references :user_bookmark, null: false

      t.timestamps null: false
    end
  end
end
