class AddCompletedToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :completed, :boolean, :default => false, :null => false
  end
end
