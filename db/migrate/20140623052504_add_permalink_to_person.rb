class AddPermalinkToPerson < ActiveRecord::Migration
  def change
    add_column :people, :permalink, :string
  end
end
