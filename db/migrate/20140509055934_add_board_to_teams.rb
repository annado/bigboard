class AddBoardToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :board_id, :integer
    add_index :teams, :board_id
  end
end
