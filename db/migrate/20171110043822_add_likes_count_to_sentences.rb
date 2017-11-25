class AddLikesCountToSentences < ActiveRecord::Migration[5.1]
  def change
    add_column :sentences, :likes_count, :integer
  end
end
