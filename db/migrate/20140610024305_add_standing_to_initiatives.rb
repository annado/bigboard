class AddStandingToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :standing, :boolean
    Initiative.reset_column_information
    reversible do |dir|
      dir.up { Initiative.update_all standing: false }
    end
    remove_column :projects, :standing
  end
end
