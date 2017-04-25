class AddThumbnailToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :thumbnail, :string
  end
end
