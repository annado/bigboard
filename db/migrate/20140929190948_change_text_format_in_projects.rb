class ChangeTextFormatInProjects < ActiveRecord::Migration
  def change
    change_column :projects, :notes, :text
  end
end
