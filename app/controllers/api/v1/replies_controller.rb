class Api::V1::RepliesController <  Api::V1::ApiController
  protect_from_forgery with: :null_session
  before_action :current_user
 
  def index
    if !@current_user
      send_unauthorized
    else
      notImplemented
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