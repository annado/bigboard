class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :manager_id
      t.integer :analyst_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
