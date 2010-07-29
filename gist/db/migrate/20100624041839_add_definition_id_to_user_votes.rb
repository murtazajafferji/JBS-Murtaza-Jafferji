class AddDefinitionIdToUserVotes < ActiveRecord::Migration
  def self.up
    add_column :user_votes, :definition_id, :int
  end

  def self.down
    remove_column :user_votes, :definition_id
  end
end
