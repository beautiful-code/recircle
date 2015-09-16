class RemoveRequestStateFromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :request_type, :integer
    add_column :requests, :request_type,:string
  end
end
