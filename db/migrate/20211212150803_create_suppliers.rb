class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :corporate_name
      t.string :cnpj
      t.string :address
      t.string :city
      t.string :state
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
