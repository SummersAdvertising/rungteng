class RenameProductPhoto < ActiveRecord::Migration
  def change
  	rename_column :products, :photo, :image
  end
end
