class AddLentToBooks < ActiveRecord::Migration
  def change
    add_column :books, :lender_id, :integer
  end
end
