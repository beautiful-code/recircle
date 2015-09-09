class AddOwnerToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :owner_id, :integer
  end
end
