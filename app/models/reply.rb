class Reply < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :comment
  has_many :votereplies, dependent: :destroy
  belongs_to :parent,  class_name: "Reply", optional: true #-> requires "parent_id" column
  has_many   :replies, class_name: "Reply", foreign_key: :parent_id, dependent: :destroy
  
  def upvotereplies
    votereplies.sum(:upvoterep)
  end

  def deep_count
    count = replies.count
    replies.each { |reply| count += reply.deep_count }
    count
  end
end
