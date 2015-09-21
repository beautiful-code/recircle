class RemoveNotificationTypeFromNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :notification_type, :string
  end
end
