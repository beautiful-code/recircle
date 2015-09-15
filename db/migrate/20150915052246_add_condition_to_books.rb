class AddConditionToBooks < ActiveRecord::Migration
  def change
    add_column :books, :condition, :integer,default: 0
  end
end
