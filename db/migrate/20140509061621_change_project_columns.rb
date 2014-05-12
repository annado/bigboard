class ChangeProjectColumns < ActiveRecord::Migration
  def change
    remove_column :projects, :kickoff
    remove_column :projects, :rolloff
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
    add_column :projects, :ship_date, :date
  end
end
