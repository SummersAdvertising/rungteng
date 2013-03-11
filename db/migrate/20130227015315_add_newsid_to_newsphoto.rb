class AddNewsidToNewsphoto < ActiveRecord::Migration
  def change
  	add_column :newsphotos, :news_id, :integer
  end
end
