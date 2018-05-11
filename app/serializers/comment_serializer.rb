require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :username, :created_at, :body, :replies
  #has_many :votecomments
  
  def username
    #object es el this o self en C
    object.user.name
  end
  
  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
  
  def replies
    object.replies
  end
end
