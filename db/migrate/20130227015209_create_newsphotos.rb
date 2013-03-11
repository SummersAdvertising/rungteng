class CreateNewsphotos < ActiveRecord::Migration
  def change
    create_table :newsphotos do |t|
      t.string :image
      t.string :name

      t.timestamps
    end
  end
end
