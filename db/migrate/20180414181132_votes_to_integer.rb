class VotesToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :contributions, :votes, :integer
  end
end
