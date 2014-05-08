class AddNetworkIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :network_id, :integer
    add_index :users, :network_id
  end
end
