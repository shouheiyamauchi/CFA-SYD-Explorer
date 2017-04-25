class AddEventIconToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_icon, :string
  end
end
