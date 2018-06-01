require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class ReplySerializer < ActiveModel::Serializer
  attributes :id, :username, :created_at, :body, :parent_id, :user_id

  has_many :replies, serializer: ReplySerializer

  def user_id
    object.user.id
  end
  
  def username
    #object es el this o self en C
    object.user.name
  end
  
  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
  
end
