class User < ApplicationRecord
  
  has_many :contributions, dependent: :destroy
  has_many :comments
  validates :name, presence: true
  validates :api_key, uniqueness: true
  has_many :votes
  has_many :votecomments
  before_create :generate_api_key
  
  # poder alguns camps que es guarden no ens faran falta o haurem d'afegir mes
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(name: auth_hash.info.nickname).first_or_create
    user.update(
      provider: auth_hash.provider, 
      uid: auth_hash.uid,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end

  def self.find_by_auth_params(provider, uid, nickname, token, secret)
    user = where(name: nickname).first_or_create
    user.update(
      provider: provider, 
      uid: uid,
      token: token,
      secret: secret
    )
    user
  end

  def owns_contribution?(contribution)
    self == contribution.user
  end

  def owns_comment?(comment)
    self == comment.user
  end

  def upvotecomment(comment)
    votecomments.create(upvotecom: 1, comment: comment)
  end
  
  def upvotedcomment?(comment)
     votecomments.exists?(upvotecom: 1, comment: comment)
  end

  def hasvotedcomment?(comment)
    votecomments.exists?(comment: comment)
  end

  def remove_votecomment(comment)
    votecomments.find_by(comment: comment).destroy
  end
  
  def upvote(contribution)
    votes.create(upvote: 1, contribution: contribution)
  end  

  def upvoted?(contribution)
    votes.exists?(upvote: 1, contribution: contribution)
  end

  def hasvoted?(contribution)
    votes.exists?(contribution: contribution)
  end
  
  def remove_vote(contribution)
    votes.find_by(contribution: contribution).destroy
  end
  
  def generate_api_key
    if self.api_key.length == 0
      self.api_key = SecureRandom.hex
    end
  end
  
end
