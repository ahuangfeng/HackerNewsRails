class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  validates :body, presence: true
end
