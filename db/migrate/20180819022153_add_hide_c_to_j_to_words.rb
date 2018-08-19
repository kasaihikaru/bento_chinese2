class AddHideCToJToWords < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :hide_c_to_j, :boolean, null:false , default:false
  end
end
