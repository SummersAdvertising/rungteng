class AddShippingfeeNoteToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :shippingfee, :integer
  	add_column :orders, :note, :text
  end
end
