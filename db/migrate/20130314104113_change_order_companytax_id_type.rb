class ChangeOrderCompanytaxIdType < ActiveRecord::Migration
  def change
  	change_column :orders, :order_companytaxID, :string
  end
end
