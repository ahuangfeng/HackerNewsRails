class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    add_reference :contributions, :comments, index: true
    add_index :contributions, [:comment_id, :created_at]
    add_reference :comments, :contribution, foreign_key: true
  end
end
