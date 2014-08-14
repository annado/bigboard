class AddAllocationsToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :product_allocation, :integer
  	add_column :teams, :internal_projects_allocation, :integer
  	add_column :teams, :support_allocation, :integer
  	add_column :teams, :unallocated_allocation, :integer
  end
end
