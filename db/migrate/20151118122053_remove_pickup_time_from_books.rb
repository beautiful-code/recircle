class RemovePickupTimeFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :pickup_time, :string
  end
end
