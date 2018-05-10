class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def prevent_unauthorized_user_access
   ## redirect_back(fallback_location: root_path, notice: "sorry, you cannot access", status: :found unless logged_in?)

    ##redirect_back(fallback_location: root_path, notice: "sorry, you have to login to access that page")
    
    redirect_to root_path, notice: 'sorry, access that page', status: :found unless logged_in?
  end

  def prevent_logged_in_user_access
      ##redirect_back(fallback_location: root_path)
      redirect_to root_path, notice: 'sorry, you cannot access that page', status: :found if logged_in?
  end

  def logged_in?
    current_user.nil? ? false : true
  end
  
  helper_method :current_user, :logged_in?

end
