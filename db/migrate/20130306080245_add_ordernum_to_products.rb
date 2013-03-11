class AddOrdernumToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :ordernum, :integer
  end
end
