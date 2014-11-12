class AddProductSpecToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :product_spec, :string
  end
end
