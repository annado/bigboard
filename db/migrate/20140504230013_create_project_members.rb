class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.references :project
      t.references :person
      t.references :role

      t.timestamps
    end
  end
end
