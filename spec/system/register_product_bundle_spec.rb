require 'rails_helper'

describe 'Usuário registra um kit' do
  
  it 'com sucesso' do
    # Arrange
    supplier = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                        email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    category = Category.create!(name: 'Bebidas')
    ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    ProductModel.create!(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit Degustação Miolo'
    check 'Vinho Tinto Miolo'
    check 'Vinho Branco Miolo'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Kit Degustação Miolo'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Vinho Branco Miolo'
    expect(page).not_to have_content 'Vinho Rose Miolo'
  end
  it 'com falha' do
    # Arrange
    supplier = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                        email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    category = Category.create!(name: 'Bebidas')
    ProductModel.create!(name: 'Vinho Tinto Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    ProductModel.create!(name: 'Vinho Rose Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    ProductModel.create!(name: 'Vinho Branco Miolo', height: '30', width: '10', length: '10',
                         weight: 800, supplier: supplier, category: category)
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: ''
    check 'Vinho Tinto Miolo'
    check 'Vinho Branco Miolo'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Não foi possível registrar o kit de produto'
    
  end
end
