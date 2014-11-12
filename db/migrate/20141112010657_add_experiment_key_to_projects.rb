class AddExperimentKeyToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :experiment_key, :string
  end
end
