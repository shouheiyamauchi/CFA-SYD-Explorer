class AddDashboardGridToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :dashboard_grid, :json
  end
end
