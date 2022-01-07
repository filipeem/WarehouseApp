class CreateJoinTableCategoriesWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_join_table :categories, :warehouses do |t|
      # t.index [:category_id, :warehouse_id]
      # t.index [:warehouse_id, :category_id]
    end
  end
end
