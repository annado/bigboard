class AddBoardToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :board_id, :integer
    add_index :projects, :board_id
  end
end
