class RemoveRequestTypeFromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :request_state, :string
  end
end
