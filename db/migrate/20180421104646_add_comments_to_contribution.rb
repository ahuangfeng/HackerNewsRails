class AddCommentsToContribution < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :numComments, :integer
  end
end
