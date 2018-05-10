class Api::V1::UsersController <  ActionController::Base
  protect_from_forgery with: :null_session

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
  
end