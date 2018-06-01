require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class ContributionSimpleSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :text, :username, :user_id, :created_at, :numComments, :points, :hasVoted

  def username
    #object es el this o self en C
    object.user.name
  end

  def hasVoted
    scope.current_user.hasvoted?(object)
  end
  
  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
end
