class CommentsController < ApplicationController
  before_action :prevent_unauthorized_user_access, except: :index

  def index
    if params[:type] == 'threads'
      @comments = Comment.order(id: :desc).all
    end
  end
  
  def show 
    @comment = Comment.find(params[:id])
    @contribution = @comment.contribution;
  end

  def edit
  end

  def create
    @contribution = Contribution.find(params[:contribution_id])
    @comment = @contribution.comments.new(user: current_user, body: comment_params[:body])
    @contribution.upComments()
    @contribution.save
    if @comment.save
      redirect_to @contribution, notice: 'Comment created'
    else
      redirect_to @contribution, notice: 'Comment was not saved. Ensure you have entered a comment'
    end
  
  
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  
end
