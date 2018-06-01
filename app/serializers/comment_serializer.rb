require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :points, :username, :created_at, :body, :parent_id, :contribution_id, :user_id
  
  def points
    object.votecomment.count
  end

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
