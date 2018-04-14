class AddVotesToContributions < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :votes, :number
  end
end
