class CreateTvshow < ActiveRecord::Migration
  def change
    create_table :tvshows do |t|
      t.integer :user_id
      t.string :title
      t.integer :episode, :null => 1, :default => 1
      t.boolean :ongoing, :null => true, :default => true
      t.datetime :date, :null => Time.now, :default => Time.now
    end
  end
end
