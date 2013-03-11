class AddAttrsToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :addDate, :date
  	add_column :products, :frontshow, :boolean
  end
end
