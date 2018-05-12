class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.belongs_to :user, foreign_key: {on_delete: :cascade}
      t.belongs_to :contributions, foreign_key: {on_delete: :cascade}
      t.text :body

      t.timestamps
    end
    add_reference :replies, :contribution, foreign_key: {on_delete: :cascade}
  end
end
