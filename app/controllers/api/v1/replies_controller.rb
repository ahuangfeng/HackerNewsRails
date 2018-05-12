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
      if params[:body] == nil or params[:body] == ""
        render json: { message: "It should have a body to comment a reply."}, status: 400 and return
      end

      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
        @comment = @contribution.comments.find_by_id(params[:comment_id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        end
        @reply = @comment.replies.new(user: @current_user, body: params[:body])

        if @reply.save
          @contribution.numComments += 1
          if @contribution.save
            render json: @reply, serializer: ReplySerializer, status: 201 and return
          else
            render json: @contribution.errors, status: 500 and return
          end
        else
          render json: @reply.errors, status: 500 and return
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
        @comment = @contribution.comments.find_by_id(params[:comment_id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        end
        @reply = @comment.replies.find_by_id(params[:id])
        if @reply.nil?
          render json: { message: "This reply doesn't exist."}, status: 404 and return
        end
        render json: @reply, serializer: ReplySerializer, status: 200 and return
      end
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
      if params[:body] == nil or params[:body] == ""
        render json: { message: "It should have a body to modify a comment."}, status: 400 and return
      end

      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
        @comment = @contribution.comments.find_by_id(params[:comment_id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        end
        @reply = @comment.replies.find_by_id(params[:id])
        if @reply.nil?
          render json: { message: "This reply doesn't exist."}, status: 404 and return
        end
        if @current_user.owns_reply?(@reply)
          @reply.body = params[:body]
          if @reply.save
            render json: @reply, serializer: ReplySerializer, status: 200 and return
          else
            render json: @reply.errors, status: 500 and return
          end
        else
          render json: { message: "Not authorized to delete this reply" }, status: 403 and return
        end
      end
    end
  end

  def destroy
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:contribution_id])
      if @contribution.nil?
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      else
        @comment = @contribution.comments.find_by_id(params[:comment_id])
        if @comment.nil?
          render json: { message: "This comment doesn't exist"}, status: 404 and return
        end
        @reply = @comment.replies.find_by_id(params[:id])
        if @reply.nil?
          render json: { message: "This reply doesn't exist."}, status: 404 and return
        end

        if @current_user.owns_reply?(@reply)
          elems_d = @reply.deep_count
          elems_d += 1
          @contribution.numComments -= (elems_d)
          @contribution.save
          @reply.replies.destroy_all
          @reply.destroy
          render json: { message: "This reply has been deleted"}, status: 200 and return
        else
          render json: { message: "Not authorized to delete this reply"}, status: 403 and return
        end
      end
    end
  end

  def send_unauthorized
    render json: { message: "Invalid Token or missing token" }, status: 401 and return
  end

  def notImplemented
    render json: {message: "Endpoint not implemented"}, :status => 501
  end
  
end