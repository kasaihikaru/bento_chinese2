class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :introduction, :text
    add_column :users, :blog, :text
    add_column :users, :study_ja, :boolean, null:false , default:false
    add_column :users, :deleted, :boolean, null:false , default:false
  end
end