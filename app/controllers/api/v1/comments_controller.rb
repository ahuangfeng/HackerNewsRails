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
        render json: @comments, each_serializer: CommentSerializer, status: 200 and return
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
        
        if params[:body] == nil or params[:body] == ''
          render json: {message: "The body field is required"}, status: 400 and return 
        end
        
        @comment = Comment.new
        @comment.body = params[:body]
        @comment.user_id = @current_user.id
        @comment.contribution_id = params[:contribution_id]
        
        if @comment.save
          @contribution.numComments += 1;
          if @contribution.save
            render json: @comment, serializer: CommentSerializer, status: 201 and return
          else
            render json: @contribution.errors, status: 500 and return 
          end
        else
          render json: @comment.errors, status: 500 and return
        end
      end
    end
  end
  
  def replyComment
    render json: { message: "Not Implemented" }, status: 501 and return
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
          render json: @comment, serializer: CommentRepliesSerializer,root: 'comment', status: 200 and return
        end
      end
    end
  end
  
  def vote
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist."}, status: 404 and return
      end

      @comment = @contribution.comments.find_by_id(params[:id])
      if @comment.nil?
        render json: { message: "This comment doesn't exits."}, status: 404 and return
      end

      if @current_user.upvotedcomment?(@comment)
        render json: { message: "You have already voted this comment."}, status: 400 and return
      else
        @current_user.upvotecomment(@comment)
        render json: { message: "You have voted this comment."}, status: 200 and return
      end
    end
  end

  def unvote
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist."}, status: 404 and return
      end

      @comment = @contribution.comments.find_by_id(params[:id])
      if @comment.nil?
        render json: { message: "This comment doesn't exits."}, status: 404 and return
      end

      if @current_user.upvotedcomment?(@comment)
        @current_user.remove_votecomment(@comment)
        render json: { message: "You have removed your vote from this comment."}, status: 200 and return
      else
        render json: { message: "You can't unvote something you haven't voted."}, status: 400 and return
      end
    end
  end

  def update
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
          if @current_user.owns_comment?(@comment)
            
            if params[:body] != nil or params[:body] != ''
              @comment.body = params[:body]
            end
            
            if @comment.changed?
              if @comment.save
                render json: @comment, serializer: CommentSerializer, status: 200 and return
              else
                render json: @comment.errors, status: 500 and return
              end
            else
              render json: @comment, serializer: CommentSerializer, status: 200 and return
            end
            
          else
            render json: { message: "Not authorized to update this comment"}, status: 403 and return
          end
        end 
      end
    end
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
            elems_d = @comment.deep_count
            @contribution.numComments -= (elems_d + 1)
            if @contribution.save
              @comment.replies.destroy
              @comment.votecomment.destroy # ja es ondelete cascade crec pero ja va be
              @comment.destroy
              render json: { message: "Comment deleted successfully"}, status: 200 and return
            else
              render json: @contribution.errors, status: 500 and return 
            end
          else
            render json: { message: "Not authorized to delete this comment"}, status: 403 and return
          end
        end
      end
    end
  end

  def send_unauthorized
    render json: { message: "Invalid Token or missing token" }, status: 401 and return
  end
  
end