class DropColumnsFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :project_id
    remove_column :people, :role_id
  end
end
