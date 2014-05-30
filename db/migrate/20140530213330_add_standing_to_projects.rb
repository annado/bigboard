class AddStandingToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :standing, :boolean
  end
end
