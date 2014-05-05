class AddDatesToProjectMember < ActiveRecord::Migration
  def change
    add_column :project_members, :start_date, :date
    add_column :project_members, :end_date, :date
  end
end
