class AddStatusToBooks < ActiveRecord::Migration
  def change
    add_column :books, :status, :boolean, default: TRUE
  end
end
