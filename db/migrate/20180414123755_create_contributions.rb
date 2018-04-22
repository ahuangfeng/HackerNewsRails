class CreateContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.string :title
      t.string :url
      t.text :text
      # t.references :comment, foreign_key: true
      t.timestamps
    end
    # add_index :contributions, [:comment_id, :created_at]

  end
end
