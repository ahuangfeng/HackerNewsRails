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
        @contributions = Contribution.where(url: nil).order(points: :desc).all
      elsif params[:type] == "new"
        @contributions = Contribution.order(id: :desc).all
      elsif params[:type] == nil
        @contributions = Contribution.where(text: nil).hottest
      else
        render json: { message: "Bad Request" }, status: 400 and return
      end
      
      render json: @contributions, each_serializer: ContributionSimpleSerializer, status: 200
      
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

      if params[:title] == nil or params[:title] == ''
        render json: {message: "The title field is required"}, status: 400 and return
      end
      
      @contribution = Contribution.new
      @contribution.title = params[:title]
      @contribution.user_id = @current_user.id
      @contribution.numComments = 0
      @contribution.points = 0

      if params[:url] != nil and params[:url] != ''
        if params[:text] != nil and params[:text] != ''
          render json: {message: "Unable to create, you must choose between type url or type ask"}, status: 400 and return
        end
        existant = Contribution.find_by(url: params[:url])
        if existant != nil
          render json: {message: "This contribution already exists. Id of this contribution:" + existant.id.to_s}, status: 409 and return
        else
          @contribution.url = params[:url]
        end
      elsif params[:text] != nil and params[:text] != ''
        if params[:url] != nil and params[:url] != ''
          render json: {message: "Unable to create, you must choose between type url or type ask"}, status: 400 and return
        end
        @contribution.text = params[:text]
      else
        render json: {message: "Cannot create a Contribution without text nor url"}, status: 400 and return
      end
      
      if @contribution.save
        render json: @contribution, serializer: ContributionSimpleSerializer, status: 201 and return
      else
        render json: @contribution.errors, status: 500 and return
      end
    end
  end
  
  #aqui s'hauria de mirar de agefir els commentaris i les replies
  def show
    if !@current_user
      send_unauthorized
    else
      @contribution = Contribution.find_by_id(params[:id])
      if @contribution.nil?
        render json: { message: "Contribution not found"}, status: 404 and return 
      else
        render json: @contribution, each_serializer: ContributionSerializer, status: 200
      end
    end
  end

  def edit # No s'implementa
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
      @contribution = Contribution.find_by(id: params[:id])
      if @contribution == nil
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      end
      # TODO: Provar que un usuario amb un altre usuari no pot modificar una contribution no seva
      if !@current_user.owns_contribution?(@contribution)
        render json: { message: "Not authorized to update this contribution"}, status: 403 and return
      end

      if params[:title] != nil
        @contribution.title = params[:title]
      end

      if params[:url] != nil and params[:url] != ''
        if params[:text] != nil and params[:text] != ''
          render json: { message: "Unable to update, you must choose between type url or type ask"}, status: 400 and return
        end
        @contribution.url = params[:url]
        @contribution.text = nil
      elsif params[:text] != nil and params[:text] != ''
        if params[:url] != nil and params[:url] != ''
          render json: { message: "Unable to update, you must choose between type url or type ask"}, status: 400 and return
        end
        @contribution.text = params[:text]
        @contribution.url = nil
      end

      if @contribution.changed?
        if @contribution.save
          render json: @contribution, serializer: ContributionSimpleSerializer, status: 200 and return 
        else
          render json: @contribution.errors, status: 500 and return 
        end
      else
        render json: @contribution, serializer: ContributionSimpleSerializer, status: 200 and return
      end
    end
  end

  def destroy
    if !@current_user
      send_unauthorized 
    else
      @contribution = Contribution.find_by(id: params[:id])
      if @contribution == nil
        render json: { message: "This contribution doesn't exist"}, status: 404 and return
      end
      if @current_user.owns_contribution?(@contribution)
        @contribution.comments.destroy
        @contribution.votes.destroy
        @contribution.destroy
        render json: { message: "Contribution deleted successfully"}, status: 200 and return
      else
        render json: { message: "Not authorized to delete this contribution"}, status: 403 and return
      end
    end
  end

  def notImplemented
    render json: {message: "Endpoint not implemented"}, :status => 501
  end

  def send_unauthorized
    render json: { message: "Invalid Token or missing token" }, status: 401
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