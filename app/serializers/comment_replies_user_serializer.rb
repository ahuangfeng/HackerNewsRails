require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class CommentRepliesUserSerializer < CommentSerializer
  attributes :replies
  
  def replies
    object.replies.where(:user_id => object.user_id)
  end
end
