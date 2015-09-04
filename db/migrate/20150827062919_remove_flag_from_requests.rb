class RemoveFlagFromRequests < ActiveRecord::Migration
  def change
    remove_column :requests, :flag, :boolean
  end
end
