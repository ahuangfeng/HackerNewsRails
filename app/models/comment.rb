class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  has_many :replies
  has_many :votecomments
  validates :body, presence: true
  
  def upvotecomments
    votecomments.sum(:upvotecom)
  end

end
