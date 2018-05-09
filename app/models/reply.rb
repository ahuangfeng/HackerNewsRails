class Reply < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :comment
  has_many :votereplies
  belongs_to :parent,  class_name: "Reply", optional: true #-> requires "parent_id" column
  has_many   :replies, class_name: "Reply", foreign_key: :parent_id, dependent: :destroy
  
  def upvotereplies
    votereplies.sum(:upvoterep)
  end
end
