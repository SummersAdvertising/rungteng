class AddOrderfaxToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :order_fax, :string
  end
end
