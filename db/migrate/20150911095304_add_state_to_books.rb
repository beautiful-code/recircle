class AddStateToBooks < ActiveRecord::Migration
  def change
    add_column :books, :state, :string,default: "unlocked"
  end
end
