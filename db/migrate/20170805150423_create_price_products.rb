class CreatePriceProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :product_prices do |t|
      t.integer :price
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
