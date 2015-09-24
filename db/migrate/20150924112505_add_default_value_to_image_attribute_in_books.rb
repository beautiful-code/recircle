class AddDefaultValueToImageAttributeInBooks < ActiveRecord::Migration
  def change
    change_column :books, :image, :string, default: "http://l7connect.com/wp-content/uploads/2015/06/no-preview.png"
  end
end
