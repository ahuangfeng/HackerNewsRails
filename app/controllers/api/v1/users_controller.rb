class Api::V1::UsersController < Api::V1::ApiController
  before_action :current_user

  def create
    
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
    
  end
  
  def send_unauthorized
    render json: { message: "Invalid Token or missing token" }, status: 401
  end

end