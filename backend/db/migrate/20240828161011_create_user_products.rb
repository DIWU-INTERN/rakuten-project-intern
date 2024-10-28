class CreateUserProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_products do |t|
      t.references :user, null: false, foreign_key: true
      t.string :product_name
      t.string :item_url
      t.string :image_url
      t.integer :price
      t.integer :review_score
      t.integer :desire_level
      t.string :gender
      t.integer :age
      t.string :prefecture
      t.string :city

      t.timestamps
    end
  end
end
