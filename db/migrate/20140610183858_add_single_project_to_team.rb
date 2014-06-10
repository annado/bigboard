class AddSingleProjectToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :single_project, :boolean
  end
end
