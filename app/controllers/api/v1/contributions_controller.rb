class Api::V1::ContributionsController <  ActionController::Base
  protect_from_forgery with: :null_session
  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end
 
  def index
    key = request.headers["Authorization"]
    if key.nil?
      render json: { message: "Missing/Wrong api-key" }, status: 401    
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
  
  #aqui s'hauria de mirar de agefir els commentaris i les replies
  def show
    @contribution = ::Contribution.find_by_id(params[:id])
    if @contribution.nil?
      render json: { message: "Contribution not found"}, status: 404
    else
      render json: @contribution, status: 200
    end
  end
  
end