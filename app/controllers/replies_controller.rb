class RepliesController < ApplicationController
  before_action :prevent_unauthorized_user_access, except: :index
  

  def index
    if params[:type] == 'threads'
      @replies = Comment.order(id: :desc).all
    end
  end

  def createWithParent
    @parentReply = Reply.find(reply_params[:parent_id])
    @contribution = @parentReply.contribution
    contributionID = @contribution.id.to_s
    @reply = @parentReply.replies.new(user: current_user, body: reply_params[:body], contribution: @contribution, parent: @parentReply)
    if @reply.save
      @parentReply.contribution.upComments()
      @parentReply.contribution.save
      redirect_to "/contributions/"+contributionID, notice: 'Reply created'
    else
      redirect_to "/replies/"+@parentReply.id.to_s, notice: @reply.save!
      # notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end

  def create
    if params[:comment_id] == nil or params[:comment_id] == ""
      @contribution = Contribution.find(params[:contribution_id])
      @reply = @contribution.replies.new(user: current_user, body: reply_params[:body])
      if @reply.save
        @contribution.upComments()
        @contribution.save
        redirect_to @contribution, notice: 'Comment created'
      else
        redirect_to @contribution, notice: 'Comment was not saved. Ensure you have entered a comment'
      end
    else
      @comment = Reply.find(params[:comment_id])
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
  end

  def destroy
    reply = Reply.find_by(id: params[:id])
    if current_user.owns_reply?(reply)
      # @reply = reply
      # @contribution = @reply.contribution
      # @contribution.numComments -= @reply.deep_count
      # @contribution.numComments -= 1
      # @contribution.save
      # @reply.replies.destroy
      # @reply.destroy
      # redirect_back(fallback_location: root_path, notice: "Reply successful deleted")
      render json: reply
    else
      redirect_back(fallback_location: root_path, notice: "Not authorized to delete this reply")
    end
  end

  def show 
    @reply = Reply.find(params[:id])
    @contribution = @reply.contribution;
  end

  def edit 
    @newreply = Reply.new
    @reply = Reply.find(params[:id])
  end

  private
    def reply_params
      params.require(:reply).permit(:body, :parent_id)
    end
end
