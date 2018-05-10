class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution
  has_many :replies, dependent: :destroy
  has_many :votecomments, dependent: :destroy
  validates :body, presence: true
  
  def upvotecomments
    votecomments.sum(:upvotecom)
  end
  
  

end
