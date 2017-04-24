class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.text :event_description
      t.string :event_location
      t.decimal :event_cost, precision: 8, scale: 2
      t.date :event_date

      t.timestamps
    end
  end
end
