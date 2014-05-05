class ChangeProjectInitiativeType < ActiveRecord::Migration
  def change
    remove_column :projects, :initiative
    add_column :projects, :initiative_id, :integer
    add_index :projects, :initiative_id
  end
end
