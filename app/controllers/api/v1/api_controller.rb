class Api::V1::ApiController < ActionController::Base

  serialization_scope :view_context

  def current_user 
    @current_user = ::User.find_by_api_key(request.headers["Authorization"])
  end

  helper_method :current_user

end
