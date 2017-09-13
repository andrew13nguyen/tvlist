class AddSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string
    add_column :users, :default_sort, :string
  end
end
