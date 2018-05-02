class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  validates :user_id, uniqueness: { scope: :contribution_id }
end
