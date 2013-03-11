class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :photo
      t.string :name
      t.integer :price
      t.integer :saleprice
      t.string :weight

      t.timestamps
    end
  end
end
