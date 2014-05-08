class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer :nid
      t.string :name

      t.timestamps
    end
    add_index :networks, :nid, unique: true
  end
end
