class AddIsadmincheckToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :isAdminCheck, :boolean
  end
end
