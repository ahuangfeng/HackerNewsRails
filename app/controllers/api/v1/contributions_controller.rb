class Api::V1::ContributionsController <  ActionController::Base
  protect_from_forgery with: :null_session
  before_action :current_user

  #FIXME: Aixo es lo que fa resources
  # GET 	      /photos 	-->         photos#index 	display a list of all photos --> s'implementa
  # GET 	      /photos/new 	-->     photos#new 	return an HTML form for creating a new photo --> NO
  # POST 	      /photos 	-->         photos#create 	create a new photo --> s'implementa
  # GET       	/photos/:id 	-->     photos#show 	display a specific photo --> s'implementa
  # GET       	/photos/:id/edit 	--> photos#edit 	return an HTML form for editing a photo --> NO
  # PATCH/PUT   /photos/:id 	-->     photos#update 	update a specific photo --> s'implementa
  # DELETE     	/photos/:id 	-->     photos#destroy 	delete a specific photo --> s'implementa

  def index
    if !@current_user
      send_unauthorized
    else
      if params[:type] == "ask"
        render json: ::Contribution.where(url: nil).order(points: :desc).all, status: 200
      elsif params[:type] == "new"
        render json: ::Contribution.order(id: :desc).all, status: 200
      elsif params[:type] == nil
        render json: ::Contribution.where(text: nil).hottest, status: 200
      else
        render json: { message: "Bad Request" }, status: 400
      end
    end
  end

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
  
  #aqui s'hauria de mirar de agefir els commentaris i les replies
  # controlar autorització (error 501)
  def show
    if !@current_user
      send_unauthorized
    else
      @contribution = ::Contribution.find_by_id(params[:id])
      if @contribution.nil?
        render json: { message: "Contribution not found"}, status: 404
      else
        render json: @contribution, status: 200
      end
    end
  end

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

  def notImplemented
    render json: {message: "Endpoint not implemented"}, :status => 501
  end

  def send_unauthorized
    render json: { message: "Invalid Token" }, status: 403
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