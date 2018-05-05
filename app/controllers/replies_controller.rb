class RepliesController < ApplicationController

  def createWithParent
    @parentReply = Reply.find(reply_params[:parent_id])
    @comment = @parentReply.comment
    commentID = @comment.id
    # {"utf8"=>"✓",
    #   "authenticity_token"=>"eCG5eL7LJzYkBElyVK/xqKW5pmQgvLunf5s+3+Xh2N8WFyXlARbyEJSx628fPcS1Cck15cUzTBQH8RlIOQKNKA==",
    #   "reply"=>{"body"=>"asdf"},
    #   "button"=>"",
    #   "contribution_id"=>"3",
    #   "comment_id"=>"4"}
    @reply = @parentReply.replies.new(user: current_user, body: reply_params[:body])
    if @reply.save
      @comment.contribution.upComments()
      @comment.contribution.save
      redirect_to "/contributions/"+params[:contribution_id], notice: 'Reply created'
    else
      redirect_to "/comments/"+commentID, notice: 'Reply was not saved. Ensure you have entered a Reply'
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
      redirect_to "/comments/"+params[:comment_id], notice: @reply.save! 
      # notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end

  def show 
    @newreply = Reply.new
    @reply = Reply.find(params[:id])
  end

  private
    def reply_params
      params.require(:reply).permit(:body)
    end
end
