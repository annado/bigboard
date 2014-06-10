class AddSecurityToInitiative < ActiveRecord::Migration
  def change
    add_column :initiatives, :security_id, :integer
  end
end
