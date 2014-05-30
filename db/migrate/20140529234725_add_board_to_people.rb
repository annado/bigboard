class AddBoardToPeople < ActiveRecord::Migration
  def change
    add_column :people, :board_id, :integer
    add_index :people, :board_id
  end
end
