class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :replies
  
  def replies
    object.replies
  end
end
