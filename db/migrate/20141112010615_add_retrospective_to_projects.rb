class AddRetrospectiveToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :retrospective, :string
  end
end
