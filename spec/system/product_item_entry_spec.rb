require 'rails_helper'

describe 'Usuario dá entrada em novos itens' do
  it 'com sucesso' do
    # Arrange
    category = Category.create(name: 'Geral')
    user = create(:user)
    w1 = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '85.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                                    weight: 300, supplier: supplier, category: category)

    # Act
    login_as(user)
    visit root_path
    click_on 'Entrada de Itens'
    fill_in 'Quantidade', with: 100
    select 'MCZ', from: 'Galpão Destino'
    select 'Pelúcia Dumbo', from: 'Produto'
    fill_in 'Preço', with: 100
    fill_in 'Lote', with: 001
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Pelúcia Dumbo')
      expect(page).to have_content('Quantidade 100')
    end
  end
  it 'e visualiza estoques no fornecedor' do
    # Arrange
    user = create(:user)
    category = Category.create!(name: 'Geral')
    w1 = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000, categories: [category])
    supplier = Supplier.create!(name: 'Samsung', corporate_name: 'Samsung do BR LTDA',
                                cnpj: '88.935.972/0001-20', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', phone: '11 1234-5678')
    
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                                  weight: 400, supplier: supplier, category: category)
    p2 = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                                    weight: 300, supplier: supplier, category: category)
    
    50.times do
      ProductItem.create!(product_model: p1, warehouse: w1, price: 100, batch: 001)
    end
    # Act
    login_as(user)
    visit root_path
    click_on 'Ver Fornecedores'
    click_on 'Samsung'
    
    # Assert
    expect(page).to have_css('th', text: 'Local')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Maceió')
      expect(page).to have_content('Quantidade: 50')
    end
  end
end
