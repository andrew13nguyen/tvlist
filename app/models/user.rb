class User < ActiveRecord::Base

  has_many :tvshows

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  def ongoing_tv_shows(sort: 'title')
    tvshows.where(ongoing: true).order(sort)
  end

  def completed_tv_shows(sort: 'title')
    tvshows.where(ongoing: false).order(sort)
  end

end
