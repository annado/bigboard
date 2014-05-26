class RemoveNetworkFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :network_id, :integer
  end
end
