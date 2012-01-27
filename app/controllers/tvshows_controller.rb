class TvshowsController < ApplicationController
  
  # GET /tvshows
  # GET /tvshows.json
  def index
    if user_signed_in?
      @user_id = current_user.id
      unless params[:sort].nil?
        @ongoing = Tvshow.get_ongoing(@user_id, params[:sort])
        @complete = Tvshow.get_complete(@user_id, params[:sort])
      else
        @ongoing = Tvshow.get_ongoing(@user_id)
        @complete = Tvshow.get_complete(@user_id)
      end

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @tvshow }
      end
    else
      respond_to do |format|
        format.html { redirect_to "#{Rails.root.to_s}/users/sign_in" }
        format.json { head :ok }
      end
    end
  end

  # GET /tvshows/1
  # GET /tvshows/1.json
  def show
    @tvshow = Tvshow.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tvshow }
    end
  end

  # GET /tvshows/new
  # GET /tvshows/new.json
  def new
    @tvshow = Tvshow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tvshow }
    end
  end

  # GET /tvshows/1/edit
  def edit
    if user_signed_in?
      if params[:id].to_s == current_user.id.to_s
        @tvshow = Tvshow.find(params[:id])
      else
        respond_to do |format|
          format.html { redirect_to tvshows_url }
          format.json { head :ok }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :root }
        format.json { head :ok }
      end
    end
  end

  # POST /tvshows
  # POST /tvshows.json
  def create
    @tvshow = Tvshow.new(params[:tvshow])

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
    if user_signed_in?
      if params[:id].to_s == current_user.id.to_s
        @tvshow = Tvshow.find(params[:id])
        # @tvshow.update_attribute(:episode, @tvshow[:episode].next)
        if (params[:option] == "next")
          @tvshow[:episode] = @tvshow[:episode].next
        else
          @tvshow[:ongoing] = FALSE
        end
        @tvshow.change(@tvshow)
      end
    
      respond_to do |format|
        if params[:sort]
          format.html { redirect_to "/tvshows/?sort="+params[:sort].sub(' ', '+') }
        else
          format.html { redirect_to tvshows_url }
        end
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to :root }
        format.json { head :ok }
      end
    end
  end

  # PUT /tvshows/1
  # PUT /tvshows/1.json
  def update
    @tvshow = Tvshow.find(params[:id])

    respond_to do |format|
      if @tvshow.change(params[:tvshow])
        # format.html { redirect_to @tvshow, :notice => 'TV show was successfully updated.' }
        format.html { redirect_to tvshows_url }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tvshow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tvshows/1
  # DELETE /tvshows/1.json
  def destroy
    @tvshow = Tvshow.find(params[:id])
    @tvshow.destroy

    respond_to do |format|
      format.html { redirect_to tvshows_url }
      format.json { head :ok }
    end
  end
end
