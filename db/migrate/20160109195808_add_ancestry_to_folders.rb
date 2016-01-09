class AddAncestryToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :ancestry, :string
    add_index :folders, :ancestry
  end
end
