class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  has_many :replies
  validates :body, presence: true
end
