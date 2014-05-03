class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.date :kickoff
      t.date :rolloff
      t.string :status
      t.string :location
      t.string :type
      t.string :initiative

      t.timestamps
    end
  end
end
