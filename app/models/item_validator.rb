class ItemValidator < ActiveModel::Validator
  def validate(record)
    unless record.warehouse.categories.include? (record.product_model.category)
      record.errors.add :warehouse, "Produto não pode ser armazenado neste galpão"
    end
  end
end