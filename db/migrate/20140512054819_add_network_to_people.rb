class AddNetworkToPeople < ActiveRecord::Migration
  def change
    add_column :people, :network_id, :integer
    add_index :people, :network_id
  end
end
