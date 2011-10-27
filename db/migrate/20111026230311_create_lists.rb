class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.integer :episode, :null => 1, :default => 1
      t.boolean :ongoing, :null => true, :default => true

      t.timestamps
    end
  end
end
