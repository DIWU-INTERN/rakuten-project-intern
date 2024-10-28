class AddUserRefToUserProducts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :user_products, :users, column: :user_id
  end
end
