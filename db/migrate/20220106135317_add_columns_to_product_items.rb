class AddColumnsToProductItems < ActiveRecord::Migration[6.1]
  def change
    add_column :product_items, :price, :integer
    add_column :product_items, :batch, :integer
  end
end
