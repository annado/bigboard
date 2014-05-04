class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
    add_index :teams, :name, unique: true
  end
end
