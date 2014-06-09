class AddBoardToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :board_id, :integer
    add_index :versions, :board_id
  end
end
