class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :message
      t.integer :read_status,default:0

      t.timestamps null: false
    end
  end
end
