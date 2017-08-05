class CreateProductUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :product_users do |t|
      t.references :product
      t.references :user

      t.timestamps
    end
  end
end
