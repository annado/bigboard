class ChangeProjectTypeColumn < ActiveRecord::Migration
  def change
    remove_column :projects, :type
    add_column :projects, :project_type, :string
  end
end
