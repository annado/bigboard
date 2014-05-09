class AddBoardToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :board_id, :integer
    add_index :initiatives, :board_id
  end
end
