class Api::V1::CommentsController <  ActionController::Base
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

  # no hauria de entrar mai aqui
  def new
    notImplemented
  end

  def create
    notImplemented
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

  # no hauria de entrar mai aqui
  def edit
    notImplemented
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
            #TODO: MIRAR ABANS DE BORRAR EL NUMCOMMENTS QUE BAIXI
            @comment.replies.destroy
            @comment.votecomments.destroy
            @comment.destroy
            render json: { message: "Comment deleted successfully"}, status: 200 and return
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

  private
    def current_user
      user = ::User.find_by_api_key(request.headers["Authorization"])
      if user.nil?
        false
      else
        @current_user = user
      end
    end
  
end