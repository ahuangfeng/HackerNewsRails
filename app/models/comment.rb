class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  # belongs_to :comment
  has_many :votecomment, dependent: :destroy
  belongs_to :parent,  class_name: "Comment", optional: true #-> requires "parent_id" column
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  belongs_to :contribution

  def upvotecomments
    votecomment.sum(:upvotecom)
  end

  def deep_count
    if replies != nil
      count = replies.count
      replies.each { |reply| count += reply.deep_count }
      count
    else
      0
    end
  end
end
