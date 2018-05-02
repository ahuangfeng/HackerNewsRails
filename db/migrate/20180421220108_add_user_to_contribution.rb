class AddUserToContribution < ActiveRecord::Migration[5.1]
  def change
    add_reference :contributions, :user, foreign_key: {on_delete: :cascade}
  end
end
