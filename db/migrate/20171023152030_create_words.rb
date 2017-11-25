class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.integer :sentence_id
      t.text :ja
      t.text :hira
      t.text :ch
      t.text :pin
      t.boolean :hide, null:false , default:false
      t.boolean :deleted, null:false , default:false
      t.timestamps
    end
  end
end