class AddEventApprovedToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_approved, :string
  end
end
