class CreateSubmits < ActiveRecord::Migration[5.1]
  def change
    create_table :submits do |t|
      t.string :title
      t.string :url
      t.string :text

      t.timestamps
    end
  end
end
