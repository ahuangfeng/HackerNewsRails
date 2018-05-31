class Api::V1::SessionsController < Api::V1::ApiController

  def getSession
    if params[:provider] == nil or params[:uid] == nil or params[:nickname] == nil or params[:token] == nil or params[:secret] == nil
      render json: {message: "The fields are incomplete: provider, uid, nickname, token, secret"}, status: 400 and return
    end
    # provider, uid, nickname, token, secret
    @user = User.find_by_auth_params(params[:provider],params[:uid],params[:nickname],params[:token] ,params[:secret])
    if @user != nil
      render json: @user, serializer: UserSerializer, status: 200 and return
    else
      render json: { message: "Error ocurred" }, status: 500 and return
    end
  end
 
end
