class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :totalprice
      t.string :order_name
      t.string :order_phone
      t.integer :order_companytaxID
      t.string :order_email
      t.string :receive_name
      t.string :receive_phone
      t.string :receive_address
      t.date :receive_date
      t.string :receive_time

      t.timestamps
    end
  end
end
