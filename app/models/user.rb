class User < ApplicationRecord
  
  has_many :contributions, dependent: :destroy
  has_many :comments
  has_many :replies
  validates :name, presence: true
  validates :api_key, uniqueness: true
  has_many :votes
  
  # poder alguns camps que es guarden no ens faran falta o haurem d'afegir mes
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    if user.api_key.length == 0
      user.update(api_key: SecureRandom.hex)
    end
    user.update(
      name: auth_hash.info.nickname,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end

  def owns_contribution?(contribution)
    self == contribution.user
  end

  def owns_comment?(comment)
    self == comment.user
  end

  def owns_reply?(reply)
    self == reply.user
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
  
end
