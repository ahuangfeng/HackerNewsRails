class Api::V1::ApiController < ActionController::Base

  def current_user 
    @current_user = ::User.find_by_api_key(request.headers["Authorization"])
  end

  helper_method :current_user

end
