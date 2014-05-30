class AddCompletedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :completed, :boolean
  end
end
