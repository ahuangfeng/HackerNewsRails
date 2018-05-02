class User < ApplicationRecord
  
  has_many :contributions, dependent: :destroy
  has_many :comments
  has_many :replies
  validates :name, presence: true
  #validates :email, presence: true
  validates :auth_token, uniqueness: true
  has_many :votes
  
  before_create :generate_authentication_token
  
  # poder alguns camps que es guarden no ens faran falta o haurem d'afegir mes
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
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

  def upvote(contribution)
    votes.create(upvote: 1, contribution: contribution)
  end  

  def upvoted?(contribution)
    votes.exists?(upvote: 1, contribution: contribution)
  end
  
  def remove_vote(contribution)
    votes.find_by(contribution: contribution).destroy
  end
  
  def generate_authentication_token
      loop do
        self.auth_token = SecureRandom.base64(64)
        break unless User.find_by(auth_token: auth_token)
      end
  end
  
end
