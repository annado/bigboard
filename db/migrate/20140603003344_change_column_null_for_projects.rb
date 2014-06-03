class ChangeColumnNullForProjects < ActiveRecord::Migration
  def change
    change_column_default :projects, :completed, false
    change_column_null :projects, :completed, false, false
  end
end
