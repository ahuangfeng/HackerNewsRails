class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contributions
  validates :body, presence: true
end
