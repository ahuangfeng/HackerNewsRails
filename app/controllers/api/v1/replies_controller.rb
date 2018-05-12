class Api::V1::RepliesController <  Api::V1::ApiController
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
        # @comment = Comment.where('contribution_id = ? AND id = ?', params[:contribution_id], params[:comment_id])
        @comment = @contribution.comments.find_by_id(params[:comment_id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        end
        render json: @comment.replies, each_serializer: ReplySerializer, status: 200 and return
      end
    end
  end

  # no hauria de entrar mai aqui
  def new
    if !@current_user
      send_unauthorized
    else
      notImplemented
    end
  end

  def create
    if !@current_user
      send_unauthorized
    else
      notImplemented
    end
  end
  
  def show
    if !@current_user
      send_unauthorized
    else
      notImplemented
    end
  end

  # no hauria de entrar mai aqui
  def edit
    if !@current_user
      send_unauthorized
    else
      notImplemented
    end
  end

  def update
    if !@current_user
      send_unauthorized
    else
      notImplemented
    end
  end

  def destroy
    if !@current_user
      send_unauthorized
    else
      notImplemented
    end
  end

  def send_unauthorized
    render json: { message: "Invalid Token or missing token" }, status: 401 and return
  end

  def notImplemented
    render json: {message: "Endpoint not implemented"}, :status => 501
  end
  
end