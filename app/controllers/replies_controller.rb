class RepliesController < ApplicationController

  def createWithParent
    @parentReply = Reply.find(reply_params[:parent_id])
    @comment = @parentReply.comment
    contributionID = @comment.contribution.id.to_s

    commentID = @comment.id.to_s
    @reply = @parentReply.replies.new(user: current_user, body: reply_params[:body],comment: @comment)
    if @reply.save
      @comment.contribution.upComments()
      @comment.contribution.save
      redirect_to "/contributions/"+contributionID, notice: 'Reply created'
    else
      redirect_to "/comments/"+commentID, notice: @reply.save!
      # notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @contribution = @comment.contribution
    @reply = @comment.replies.new(user: current_user, body: reply_params[:body])
    if @reply.save
      @comment.contribution.upComments()
      @comment.contribution.save
      redirect_to "/contributions/"+params[:contribution_id], notice: 'Reply created'
    else
      redirect_to "/comments/"+params[:comment_id], notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end

  def destroy
    reply = Reply.find_by(id: params[:id])
    if current_user.owns_reply?(reply)
      @reply = reply
      @contribution = @reply.comment.contribution
      @contribution.numComments -= @reply.deep_count
      @contribution.numComments -= 1
      @contribution.save
      @reply.replies.destroy
      #@reply.votes.destroy
      @reply.destroy
      redirect_back(fallback_location: root_path, notice: "Reply successful deleted")
    else
      redirect_back(fallback_location: root_path, notice: "Not authorized to delete this reply")
    end
  end

  def show 
    @newreply = Reply.new
    @reply = Reply.find(params[:id])
  end

  private
    def reply_params
      params.require(:reply).permit(:body, :parent_id)
    end
end
