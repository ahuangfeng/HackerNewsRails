class Api::V1::ContributionsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end
 
  def index
    key = request.headers["Authorization"]
    type = request.headers["type"]
    if key.nil?
      render json: { message: "missing/wrong api-key" }, status: 401    
    else
      if type == "ask"
        render json: Contribution.where(url: nil).order(points: :desc).all.to_json, status: 200
      elsif type == "new"
        render json: Contribution.order(id: :desc).all.to_json, status: 200
      elsif type == nil
        render json: Contribution.where(text: nil).hottest.to_json, status: 200
      else
        render json: { message: "Bad Request" }, status: 400
      end
    end
  end
  
end