class Contribution < ApplicationRecord
  belongs_to :user
  #default_scope -> { order(created_at: :desc) }
  scope :hottest, -> { order(points: :desc) }

  validates :url, :format => URI::regexp(%w(http https)) , :allow_blank => true
  has_many :comments, dependent: :destroy #, :class_name => 'Contribution'
  has_many :votes, dependent: :destroy
  
  def upvotes
    votes.sum(:upvote)
  end
  def upComments()
    self.numComments += 1
  end 

  def downComments(count)
    self.numComments -= count
  end

  def calc_hot_score
    points = upvotes
    time_ago_in_hours = ((Time.now - created_at) / 3600).round
    score = hot_score(points)
    update_attributes(points: points, hot_score: score)
  end
  
  private
  
  def hot_score(points)
    points
  end
  
end
