class AddShippingfeeNoteToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :shippingfee, :integer, :default => 0
  	add_column :orders, :note, :text
  end
end
