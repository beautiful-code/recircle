class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_type
      t.text :event_data

      t.timestamps null: false
    end
  end
end
