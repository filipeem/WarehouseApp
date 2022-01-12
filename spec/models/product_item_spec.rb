require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  it 'should generate a code' do
    # Arrange
    category = Category.create(name: 'Geral')
    w1 = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)

    # Act
    item = ProductItem.create!(product_model: p1, warehouse: w1, price: 100, batch: 001)
    
    # Assert
    expect(item.code).not_to eq nil
    expect(item.code.length).to eq 20
  end

  it 'should generate a random code' do
    # Arrange
    category = Category.create(name: 'Geral')
    w1 = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)
    
    # Act
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'
    item = ProductItem.create!(product_model: p1, warehouse: w1, price: 100, batch: 001)

    # Assert
    expect(item.code).to eq '6WL0esFqq9gQMDGrYBjV'
end

  it 'Código é único' do
    category = Category.create(name: 'Geral')
    w1 = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)
    
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'
    item = ProductItem.create!(product_model: p1, warehouse: w1, price: 100, batch: 001)
    item2 = ProductItem.new(product_model: p1, warehouse: w1, price: 100, batch: 001)
    
    result = item2.valid?

    expect(result).to eq false
  end

  it 'lote é obrigatório' do
    category = Category.create!(name: 'Geral')
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create!(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)

    item = ProductItem.new(product_model: p1, warehouse: w1, price: 100, batch: '')

    result = item.valid?

    expect(result).to eq false
  end

  it 'preço é obrigatório' do
    category = Category.create!(name: 'Geral')
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create!(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)

    item = ProductItem.new(product_model: p1, warehouse: w1, price: '', batch: 001)

    result = item.valid?

    expect(result).to eq false
  end

  it 'só pode ser cadastrado em galpões com mesma categoria' do
    category1 = Category.create!(name: 'Brinquedos')
    category2 = Category.create!(name: 'Alimentos')
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category2])
    supplier = Supplier.create!(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category1)

    item = ProductItem.new(product_model: p1, warehouse: w1, price: '50', batch: 001)

    result = item.valid?

    expect(result).to eq false
  end

end
