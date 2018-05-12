require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class ContributionSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :text, :username, :created_at, :numComments, :points
  has_many :comments, serializer: CommentRepliesSerializer
  
  
  def username
    #object es el this o self en C
    object.user.name
  end
  
  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
end
