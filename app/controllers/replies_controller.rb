class RepliesController < ApplicationController

  def create
    @comment = Comment.find(params[:comment_id])
    logger.debug "Article should be valid: #{@comment.present?}"
    @contribution = @comment.contribution
    @reply = @comment.replies.new(user: current_user, body: reply_params[:body])
    @comment.contribution.upComments()
    @comment.contribution.save
    if @reply.save
      redirect_to "/comments/"+params[:comment_id], notice: 'Reply created'
    else
      redirect_to "/comments/"+params[:comment_id], notice: 'Reply was not saved. Ensure you have entered a Reply'
    end
  end

  private
    def reply_params
      params.require(:reply).permit(:body)
    end
end
