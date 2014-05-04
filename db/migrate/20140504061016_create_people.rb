class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :uid
      t.string :name
      t.string :image
      t.references :team, index: true
      t.references :project, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
