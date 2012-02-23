class Tvshow < ActiveRecord::Base
  validates_presence_of :user_id, :title, :episode
  attr_accessible :user_id, :title, :episode, :ongoing, :date
  
  def change(params)
    unless params[:episode].to_s == self.episode.to_s
      update_attributes(:title => params[:title], :episode => params[:episode].to_i, :date => Time.now, :ongoing => params[:ongoing])
    else
      update_attributes(:title => params[:title], :ongoing => params[:ongoing])
    end
  end
  
  def self.get_ongoing(user_id, sort = "title")
#     sql_str = <<SQLSTR
# SELECT tvshows.* FROM tvshows WHERE tvshows.user_id = #{user_id} AND tvshows.ongoing = TRUE ORDER BY #{sort}
# SQLSTR
#     self.find_by_sql(sql_str)
    shows = Tvshow.find(:all, :conditions => ["user_id = ? and ongoing = ?", user_id, true], :order => sort)
    return shows
  end
  
  def self.get_complete(user_id, sort = "title", order = nil)
#     sql_str = <<SQLSTR
# SELECT tvshows.* FROM tvshows WHERE tvshows.user_id = #{user_id} AND tvshows.ongoing = FALSE ORDER BY #{sort}
# SQLSTR
#     self.find_by_sql(sql_str)
    shows = Tvshow.find(:all, :conditions => ["user_id = ? and ongoing = ?", user_id, false], :order => sort)
    return shows
  end
end
