require 'rails_helper'

describe 'Visitante deleta um produto' do
  it 'usuário não logado não consegue deletar o produto' do
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
    
    visit root_path
    click_on 'Ver Produtos'
    click_on 'Vinho Tinto Miolo'
    within ("button#delete") do
      click_on 'Apagar'
    end
    
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um botão na tela de produto' do
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
    user = User.create!(email: 'usuario@email.com', password: '12345678')

    login_as(user)
    visit root_path
    click_on 'Ver Produtos'
    click_on 'Vinho Tinto Miolo'
    within ("button#delete") do
      click_on 'Apagar'
    end
    
    expect(page).not_to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Vinho Rose Miolo'
    expect(page).to have_content 'Vinho Branco Miolo'
  end

end