class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.text :name
      t.text :url
      t.text :name_selector
      t.text :price_selector

      t.timestamps
    end
  end
end
