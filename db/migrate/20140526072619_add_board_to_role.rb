class AddBoardToRole < ActiveRecord::Migration
  def change
    add_column :roles, :board_id, :integer
    add_index :roles, :board_id
  end
end
