class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :date
    add_column :users, :sex, :string
    add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
    add_column :users, :address_suburb, :string
    add_column :users, :address_state, :string
    add_column :users, :address_pcode, :integer
    add_column :users, :parent_id, :integer
    add_column :users, :organisation, :string
    add_column :users, :role, :string
  end
end
