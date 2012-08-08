class ApplicationController < ActionController::Base
  protect_from_forgery
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  
  def not_found
    render :template => 'pages/404', :status => :not_found
  end
end
