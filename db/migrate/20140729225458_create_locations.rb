class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.references :board, null: false, index: true
      t.timestamps
    end

    rename_column :people, :location, :location_old
    add_column :people, :location_id, :integer
    add_column :boards, :show_people_location, :boolean, :default => false

    rename_column :projects, :location, :location_old
    add_column :projects, :location_id, :integer
    add_column :boards, :show_project_location, :boolean, :default => false
  end
end
