class CreateBoards < ActiveRecord::Migration
  def change
    drop_table :boards
    create_table :boards do |t|
      t.integer :network_id
      t.string :name

      t.timestamps
    end
  end
end
