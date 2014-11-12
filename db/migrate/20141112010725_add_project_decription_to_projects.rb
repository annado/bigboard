class AddProjectDecriptionToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :project_description, :text
  end
end
