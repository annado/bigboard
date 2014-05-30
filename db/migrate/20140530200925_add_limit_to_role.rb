class AddLimitToRole < ActiveRecord::Migration
  def change
    add_column :roles, :limit, :integer
  end
end
