class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :people, :location, :string
  end
end
