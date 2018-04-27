class Reply < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :comment
end
