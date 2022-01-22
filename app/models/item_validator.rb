class ItemValidator < ActiveModel::Validator
  def validate(record)
    unless record.warehouse.categories.include? (record.product_model.category)
      record.errors.add :warehouse, "Produto não pode ser armazenado neste galpão"
    end
    unless record.product_model.active? 
      record.errors.add :product_model, "Modelo de produto inativo"
    end
  end
end