require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class ContributionSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :text, :username, :created_at, :numComments, :points , :comments
  has_many :comments
  
  def comments
    object.comments.map do |comment|
      CommentSerializer.new(comment, scope: scope, root: false, contribution: object)
    end
  end
  
  def username
    #object es el this o self en C
    object.user.name
  end
  
  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
end
