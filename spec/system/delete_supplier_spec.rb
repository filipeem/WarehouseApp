require 'rails_helper'

describe 'Visitante deleta um fornecedor' do
  it 'usuário não logado não consegue deletar o fornecedor' do
    supplier1 = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                                cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                                email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    supplier2 = Supplier.create!(name: 'Vinícola Garibaldi', corporate_name: 'Garibaldi Fábrica de Bebidas LTDA',
                                cnpj: '01.005.325/0001-54', address: 'Avenida Cabernet, 500',
                                email: 'contato@garibaldi.com', phone: '54 1234-5678')
    
    visit root_path
    click_on 'Ver Fornecedores'
    click_on 'Vinícola Miolo'
    within ("button#delete") do
      click_on 'Apagar'
    end
    
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um botão na tela de produto' do
    supplier1 = Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                                cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                                email: 'contato@miolovinhos.com', phone: '71 1234-5678')
    supplier2 = Supplier.create!(name: 'Vinícola Garibaldi', corporate_name: 'Garibaldi Fábrica de Bebidas LTDA',
                                cnpj: '01.005.325/0001-54', address: 'Avenida Cabernet, 500',
                                email: 'contato@garibaldi.com', phone: '54 1234-5678')
    user = User.create!(email: 'usuario@email.com', password: '12345678')

    login_as(user)
    visit root_path
    click_on 'Ver Fornecedores'
    click_on 'Vinícola Miolo'
    within ("button#delete") do
      click_on 'Apagar'
    end
    
    expect(page).not_to have_content 'Vinícola Miolo'
    expect(page).to have_content 'Vinícola Garibaldi'
    
  end

end