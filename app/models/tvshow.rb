class Tvshow < ActiveRecord::Base
  validates_presence_of :user_id, :title, :episode
  # attr_accessible :user_id, :title, :episode, :ongoing, :date
  
  def change(option, params)
    if self.user_id != params[:user_id]
      false
    elsif option == 'next'
      update_attributes(episode: self.episode.next, date: Time.now)
    elsif option == 'complete'
      update_attributes(ongoing: false)
    else
      update_attributes(params.merge(date: Time.now))
    end
  end
  
  def self.get_ongoing(user_id, sort = 'title')
    Tvshow.where(user_id: user_id, ongoing: true).order(sort)
  end
  
  def self.get_complete(user_id, sort = 'title', order = nil)
    Tvshow.where(user_id: user_id, ongoing: false).order(sort)
  end
end
