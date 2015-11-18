class AddPickUpTimeToBooks < ActiveRecord::Migration
  def change
    add_column :books, :pickup_time, :datetime
  end
end
