class CreateVotereplies < ActiveRecord::Migration[5.1]
  def change
    create_table :votereplies do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :reply, foreign_key: true
      t.integer :upvoterep, default: 0
      t.integer :downvoterep, default: 0

      t.timestamps
    end
  end
end
