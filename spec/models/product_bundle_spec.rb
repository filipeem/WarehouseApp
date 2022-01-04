require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  it 'should generate an SKU' do
    # Arrange
    supplier = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                        email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    category = Category.create!(name: 'Bebidas')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p3 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)

    bundle = ProductBundle.new(name: 'Kit Degustação Miolo', product_model: [p1, p2, p3])

    # Act
    bundle.save()

    # Assert
    expect(bundle.sku).not_to eq nil
    expect(bundle.sku.length).to eq 20
  end

  it 'should generate a random SKU' do
    # Arrange
    supplier = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                        email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    category = Category.create!(name: 'Bebidas')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p3 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)

    bundle = ProductBundle.new(name: 'Kit Degustação Miolo', product_model: [p1, p2, p3])
    
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'

    # Act
    bundle.save()
    

    # Assert
    expect(bundle.sku).to eq '6WL0esFqq9gQMDGrYBjV'
  end

  it 'should not update sku' do
    # Arrange
    supplier = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                        email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    category = Category.create!(name: 'Bebidas')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p3 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)

    bundle = ProductBundle.new(name: 'Kit Degustação Miolo', product_model: [p1, p2, p3])
    bundle.save()
    sku = bundle.sku
    
    # Act
    bundle.update(name: 'Kit Natal')

    # Assert
    expect(bundle.name).to eq 'Kit Natal'
    expect(bundle.sku).to eq sku

  end

  it 'SKU é único' do
    
    supplier = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                        email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    category = Category.create!(name: 'Bebidas')
    p1 = ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    p3 = ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'
    bundle = ProductBundle.create!(name: 'Kit Degustação Miolo', product_model: [p1, p2, p3])
    bundle2 = ProductBundle.new(name: 'Kit Natal', product_model: [p1, p2])
    
    result = bundle2.valid?

    expect(result).to eq false
  end
end
