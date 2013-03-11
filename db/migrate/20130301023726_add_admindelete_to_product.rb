class AddAdmindeleteToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :admindelete, :boolean
  end
end
