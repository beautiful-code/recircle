class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :landmark, :string
    add_column :users, :area, :string
    add_column :users, :fulladdress, :string
  end
end
