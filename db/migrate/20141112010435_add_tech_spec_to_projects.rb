class AddTechSpecToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :tech_spec, :string
  end
end
