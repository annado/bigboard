class AddNetworkToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :network_id, :integer
    add_index :teams, :network_id
  end
end
