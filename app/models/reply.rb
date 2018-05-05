class Reply < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :comment
  belongs_to :parent,  class_name: "Reply" #-> requires "parent_id" column
  has_many   :replies, class_name: "Reply", foreign_key: :parent_id, dependent: :destroy
end
