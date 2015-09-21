class RemoveMessageFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :message, :string
  end
end
