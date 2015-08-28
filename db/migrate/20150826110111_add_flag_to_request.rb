class AddFlagToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :flag, :boolean , :default => true
  end
end
