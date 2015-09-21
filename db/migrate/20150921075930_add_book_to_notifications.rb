class AddBookToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :book, index: true, foreign_key: true
    add_column :notifications, :type, :string
  end
end
