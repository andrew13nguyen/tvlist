namespace :heroku do

  desc 'checking if scheduler keeps the dyno active'
  task poll: :environment do
    Tvshow.count
  end

end
