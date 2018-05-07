class AddReplyRefToReply < ActiveRecord::Migration[5.1]
  def change
    add_column :replies, :parent_id, :integer
  end
end
