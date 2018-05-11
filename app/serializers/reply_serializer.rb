class ReplySerializer < ActiveModel::Serializer
  attributes :id, :body
  has_many :replies
end
