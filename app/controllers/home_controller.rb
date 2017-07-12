class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to "/tvshows"
    end
  end

  def ping
    render :layout => false
  end

end
