class Tvshow < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :user_id, :title, :episode
  # attr_accessible :user_id, :title, :episode, :ongoing, :date
  
  def change(option, params)
    if self.user_id != params[:user_id]
      false
    elsif option == 'next'
      update_attributes(episode: self.episode.next, date: Time.now)
    elsif option == 'completed'
      update_attributes(ongoing: false)
    else
      update_attributes(params.merge(date: Time.now))
    end
  end

end
