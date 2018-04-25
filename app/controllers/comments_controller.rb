class CommentsController < ApplicationController
  before_action :prevent_unauthorized_user_access, except: :index

  def index
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
  end
  
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
  
end
