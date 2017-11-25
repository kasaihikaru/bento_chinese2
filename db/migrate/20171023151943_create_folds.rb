class CreateFolds < ActiveRecord::Migration[5.1]
  def change
    create_table :folds do |t|
      t.integer :user_id
      t.string :name
      t.boolean :deleted, null:false , default:false
      t.timestamps null: false
    end
  end
end
