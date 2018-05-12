class Api::V1::CommentsController <  Api::V1::ApiController
  protect_from_forgery with: :null_session
  before_action :current_user
 
  def index
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
        @comments = Comment.where(contribution_id: params[:contribution_id])
        render json: @comments, each_serializer: CommentSimpleSerializer, status: 200 and return
      end
    end
  end


  def create
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
        @comment = Comment.new
        @comment.body = params[:body]
        @comment.user_id = @current_user.id
        @comment.contribution_id = params[:contribution_id]
        @contribution.numComments += 1;
        
        if @contribution.save
          if @comment.save
            render json: @comment, serializer: CommentSimpleSerializer, status 201 and return
          else
            render json: @comment.errors, status: 500 and return
          end
        else
          render json: @contribution.errors, status: 500 and return 
        end
      end
    end
  end
  
  
  def show
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        else
          render json: @comment, each_serializer: CommentSerializer, status: 200 and return
        end
      end
    end
  end
  

  def update
    notImplemented
  end

  def destroy
    if !@current_user
      send_unauthorized 
    else
      @contribution = Contribution.find_by(id: params[:contribution_id])
      if @contribution == nil
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
         @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        else
          if @current_user.owns_comment?(@comment)
            elems_d = @comment.replies.count
            @contribution.numComments -= (elems_d + 1)
            if @contribution.save
              @comment.replies.destroy
              @comment.votecomments.destroy
              @comment.destroy
              render json: { message: "Comment deleted successfully"}, status: 200 and return
            else
               render json: @contribution.errors, status: 500 and return 
            end
          else
            render json: { message: "Not authorized to delete this contribution"}, status: 403 and return
          end
        end
      end
    end
  end

  def notImplemented
    render json: {message: "Endpoint not implemented"}, :status => 501
  end
  
end