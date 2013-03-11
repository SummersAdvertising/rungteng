class RemoveSalepriceFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :saleprice
  end
end
