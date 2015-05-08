class TvshowsController < ApplicationController
  before_filter :require_login
  
  def require_login
    unless user_signed_in?
      # flash[:error] = "You must be logged in to access this section"
      redirect_to "/users/sign_in"
    end
  end

  def index
    user_id = current_user.id
    unless params[:sort].nil?
      @ongoing = Tvshow.get_ongoing(user_id, params[:sort])
      @complete = Tvshow.get_complete(user_id, params[:sort])
    else
      @ongoing = Tvshow.get_ongoing(user_id)
      @complete = Tvshow.get_complete(user_id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tvshow }
    end
  end

  def show
    @tvshow = Tvshow.find_by_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tvshow }
    end
  end

  def new
    @tvshow = Tvshow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tvshow }
    end
  end

  def edit
    @tvshow = Tvshow.find_by_id(params[:id])
    unless @tvshow.user_id == current_user.id
      respond_to do |format|
        format.html { redirect_to tvshows_url }
        format.json { head :ok }
      end
    end
  end

  def create
    @tvshow = Tvshow.new(tvshow_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @tvshow.save
        # format.html { redirect_to @tvshow, :notice => 'TV show was successfully created.' }
        # format.json { render :json => @tvshow, :status => :created, :location => @tvshow }
        format.html { redirect_to tvshows_url }
        format.json { head :ok }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tvshow.errors, :status => :unprocessable_entity }
      end
    end
  end

  def change
    @tvshow = Tvshow.find_by_id(params[:id])

    if @tvshow.change(params[:option], {user_id: current_user.id})
      result = @tvshow.reload.attributes.except('user_id')
      result['date'] = result['date'].strftime("%B %d, %Y")
    else
      Rails.logger.warn("didn't save correctly")
      # TODO: make a failure result
    end

    render :json => result
  end

  def update
    @tvshow = Tvshow.find_by_id(params[:id])

    if @tvshow.change('update', tvshow_params.merge(user_id: current_user.id))
      result = @tvshow.reload.attributes.except('user_id')
      result['date'] = result['date'].strftime("%B %d, %Y")
    else
      Rails.logger.warn("didn't save correctly")
      # TODO: make a failure result
    end

    render :json => result
  end

  def destroy
    @tvshow = Tvshow.find_by_id(params[:id])
    @tvshow.destroy

    respond_to do |format|
      format.html { redirect_to tvshows_url }
      format.json { head :ok }
    end
  end

  private

  def tvshow_params
    params.require(:tvshow).permit(:title, :episode, :ongoing, :date)
  end
end
