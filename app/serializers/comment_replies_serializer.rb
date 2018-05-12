require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class CommentRepliesSerializer < CommentSerializer
  attributes :replies

  def replies
    object.replies
  end
end
