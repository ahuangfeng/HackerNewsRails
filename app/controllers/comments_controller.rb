class CommentsController < ApplicationController
  before_action :prevent_unauthorized_user_access, except: :index
  
  def index
    if params[:type] == 'threads'
      @comments = Comment.order(id: :desc).all
    end
  end

  def createWithParent
    @parentComment = Comment.find(comment_params[:parent_id])
    @contribution = @parentComment.contribution
    contributionID = @contribution.id.to_s
    @reply = @parentComment.replies.new(user: current_user, body: comment_params[:body], contribution: @contribution, parent: @parentComment)
    if @reply.save
      @parentComment.contribution.upComments()
      @parentComment.contribution.save
      redirect_to "/contributions/"+contributionID, notice: 'Reply created'
    else
      redirect_to "/comments/"+@parentComment.id.to_s, notice: @reply.save!
      # notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end

  def create
    @contribution = Contribution.find(params[:contribution_id])
    @comment = @contribution.comments.new(user: current_user, body: comment_params[:body], contribution: @contribution)
    if @comment.save
      @contribution.upComments()
      @contribution.save
      redirect_to @contribution, notice: 'Comment created'
    else
      redirect_to @contribution, notice: 'Comment was not saved. Ensure you have entered a comment'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if current_user.owns_comment?(@comment)
      @contribution = @comment.contribution
      @contribution.numComments -= @comment.deep_count
      @contribution.numComments -= 1
      @contribution.save
      @comment.replies.destroy
      @comment.destroy
      redirect_back(fallback_location: root_path, notice: "Reply successful deleted")
    else
      redirect_back(fallback_location: root_path, notice: "Not authorized to delete this reply")
    end
  end

  def show 
    @comment = Comment.find(params[:id])
    @contribution = @comment.contribution;
  end

  def edit 
    @newreply = Comment.new
    @reply = Comment.find(params[:id])
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
