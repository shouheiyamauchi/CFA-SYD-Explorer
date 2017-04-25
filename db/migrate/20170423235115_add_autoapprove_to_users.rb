class AddAutoapproveToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :autoapprove, :string
  end
end
