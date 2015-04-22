class Tvshow < ActiveRecord::Base
  validates_presence_of :user_id, :title, :episode
  # attr_accessible :user_id, :title, :episode, :ongoing, :date
  
  def change(option, params)
    if option == "next"
      update_attributes(:title => params[:title], :episode => params[:episode].next, :date => Time.now, :ongoing => params[:ongoing])
    elsif params[:episode].to_i != self.episode
      update_attributes(:title => params[:title], :episode => params[:episode], :date => Time.now, :ongoing => params[:ongoing])
    else
      update_attributes(:title => params[:title], :ongoing => params[:ongoing])
    end
  end
  
  def self.get_ongoing(user_id, sort = "title")
    Tvshow.where(user_id: user_id, ongoing: true).order(sort)
  end
  
  def self.get_complete(user_id, sort = "title", order = nil)
    Tvshow.where(user_id: user_id, ongoing: false).order(sort)
  end
end
