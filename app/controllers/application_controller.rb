class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def not_found
    render :template => 'pages/404', :status => :not_found
  end
end
