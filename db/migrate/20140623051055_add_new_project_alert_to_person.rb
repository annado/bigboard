class AddNewProjectAlertToPerson < ActiveRecord::Migration
  def change
    add_column :people, :new_project_alert, :string
  end
end
