class Api::V1::UsersController <  ActionController::Base
  protect_from_forgery with: :null_session
  before_action :current_user

  def index
    notImplemented
  end

  # no hauria de entrar mai aqui
  def new
    notImplemented
  end

  def create
    notImplemented
  end
  
  def show
    notImplemented
  end

  # no hauria de entrar mai aqui
  def edit
    notImplemented
  end

  def update
    notImplemented
  end

  def destroy
    notImplemented
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