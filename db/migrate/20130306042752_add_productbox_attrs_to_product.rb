class AddProductboxAttrsToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :producttype, :string
  	add_column :products, :description, :text
  end
end
