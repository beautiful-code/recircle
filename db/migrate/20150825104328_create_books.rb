class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.string :image

      t.timestamps null: false
    end
  end
end
