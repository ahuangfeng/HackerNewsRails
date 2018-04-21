class AddCommentsIdToContribution < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :comment_id, :integer
    add_index :contributions, :comment_id
    add_index :contributions, :created_at
  end
end
