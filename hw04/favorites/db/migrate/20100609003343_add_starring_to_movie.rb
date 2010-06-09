class AddStarringToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :starring, :text
  end

  def self.down
    remove_column :movies, :starring
  end
end
