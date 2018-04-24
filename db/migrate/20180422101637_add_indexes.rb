class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    add_reference :contributions, :comments, index: true
    add_reference :comments, :contribution, foreign_key: true
  end
end
