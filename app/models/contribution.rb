class Contribution < ApplicationRecord
  belongs_to :user
  #default_scope -> { order(created_at: :desc) }
  validates :url, :format => URI::regexp(%w(http https)) , :allow_blank => true
  has_many :comments #, :class_name => 'Contribution'
  def upVote()
    self.votes += 1
  end
  def upComments()
    self.numComments += 1
  end
end
