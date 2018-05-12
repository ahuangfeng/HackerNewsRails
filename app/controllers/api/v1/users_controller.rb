class Api::V1::UsersController < Api::V1::ApiController
  before_action :current_user

  def create
    if params[:name] == nil or params[:name] == ""
      render json: {message: "A user should have a name."}, status: 400 and return
    end

    existant = User.find_by_name(params[:name])
    if existant != nil
      render json: { message: "This name already exists"}, status: 400 and return
    end

    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.about = params[:about]

    if @user.save
      render json: @user, serializer: UserSerializer, status: 200 and return
    else
      render json: @user.errors, status: 500 and return
    end

  end
  
  def show
    if !@current_user
      send_unauthorized
    else
      @user = User.find_by_id(params[:id])
      if @user.nil?
        render json: { message: "User not found"}, status: 404 and return
      else
        if @user.id == @current_user.id
          render json: @user, serializer: UserSerializer, status: 200 and return
        else
          render json: @user, serializer: UserSimpleSerializer, root: 'user', status: 200 and return
        end
      end
    end
  end

  def update
    if !@current_user
      send_unauthorized
    else
      @user = User.find_by_id(params[:id])
      if @user == nil
        render json: { message: "This user doesn't exist"}, status: 404 and return
      end
      
      if @user.id != @current_user.id
        render json: { message: "Not authorized to update this user"}, status: 403 and return
      end
      
      if params[:name] != nil
        @user.name = params[:name]
      end
      if params[:email] != nil
        @user.email = params[:email]
      end
      if params[:about] != nil
        @user.about = params[:about]
      end
      
      if @user.changed?
        if @user.save
          render json: @user, serializer: UserSerializer, status: 200 and return
        else
          render json: @user.errors, status: 500 and return
        end
      else
        render json: @user, serializer: UserSerializer, status: 200 and return
      end
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
    if @user == @current_user
      @user.contributions.destroy_all
      @user.comments.destroy_all
      @user.replies
      @user.destroy
      render json: { message: "All the data from this user has been deleted."}, status: 200 and return
    else
      render json: {message: "You don't have permissions to delete this user."}, status: 400 and return
    end
  end
  
  def send_unauthorized
    render json: { message: "Invalid Token or missing token" }, status: 401
  end

end