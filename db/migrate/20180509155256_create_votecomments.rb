class CreateVotecomments < ActiveRecord::Migration[5.1]
  def change
    create_table :votecomments do |t| #nose si sha de canviar el nom
      t.belongs_to :user, foreign_key: true
      t.belongs_to :comment, foreign_key: true
      t.integer :upvotecom, default: 0
      t.integer :downvotecom, default: 0

      t.timestamps
    end
  end
end
