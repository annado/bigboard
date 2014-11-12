class AddYammerGroupToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :yammer_group, :string
  end
end
