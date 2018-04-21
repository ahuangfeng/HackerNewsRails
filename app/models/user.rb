class User < ApplicationRecord
  has_many :contributions, dependent: :destroy
  validates :name, presence: true
  #validates :email, presence: true
  validates :auth_token, uniqueness: true
  
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
  
  def generate_authentication_token
      loop do
        self.auth_token = SecureRandom.base64(64)
        break unless User.find_by(auth_token: auth_token)
      end
  end
  
end
