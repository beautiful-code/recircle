class AddTypeToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :request_type, :integer,:default => 0
  end
end
