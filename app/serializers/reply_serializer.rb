class ReplySerializer < ActiveModel::Serializer
  attributes :id, :body, :replies
  
  def replies
    object.replies.where(parent_id: object.id)
  end
end
