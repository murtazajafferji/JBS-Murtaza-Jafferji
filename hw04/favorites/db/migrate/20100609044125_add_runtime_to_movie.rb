class AddRuntimeToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :runtime, :integer
  end

  def self.down
    remove_column :movies, :runtime
  end
end
