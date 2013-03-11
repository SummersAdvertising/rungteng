class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
  end
end
