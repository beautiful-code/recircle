class AddLentToBooks < ActiveRecord::Migration
  def change
    add_column :books, :borrower_id, :integer
  end
end
