class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :prefecture, :string
    add_column :users, :city, :string
  end
end
