class AddPointsAndHotscoreToContribution < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :points, :integer
    add_column :contributions, :hot_score, :float
  end
end
