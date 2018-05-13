require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class CommentRepliesSerializer < CommentSerializer
  has_many :replies, serializer: ReplySerializer

end
