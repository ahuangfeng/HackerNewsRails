class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    add_reference :contributions, :comment, index: true
    add_index :contributions, [:comment_id, :created_at]
  end
end
