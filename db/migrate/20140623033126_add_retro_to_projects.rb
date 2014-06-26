class AddRetroToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :retro, :boolean
  end
end
