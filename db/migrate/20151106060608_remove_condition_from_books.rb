class RemoveConditionFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :condition, :integer
  end
end
