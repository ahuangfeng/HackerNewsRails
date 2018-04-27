class ReplyController < ApplicationController
  
  def create
    @comment = Comment.find(params[:id])
    @reply = @comment.replies.new(user: current_user, body: reply_params[:body])
    @contribution.upComments()
    @contribution.save
    if @reply.save
      redirect_to @comment, notice: 'Reply created'
    else
      redirect_to @comment, notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end
end
