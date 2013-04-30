class CreateGuestcounts < ActiveRecord::Migration
  def change
    create_table :guestcounts do |t|
      t.integer :count, :default => 0

      t.timestamps
    end
  end
end
