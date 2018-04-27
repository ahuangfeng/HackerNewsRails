class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :comment, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
