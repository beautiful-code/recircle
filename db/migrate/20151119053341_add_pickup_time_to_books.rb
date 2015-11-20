class AddPickupTimeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :pickup_time, :text
  end
end
