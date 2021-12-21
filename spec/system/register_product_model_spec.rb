require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'visitante não vê o menu' do
    visit root_path
    expect(page).not_to have_link('Cadastrar modelo de produto')
  end

  it 'visitante não acessa diretamente o formulário' do
    # Arrange

    # Act
    visit new_product_model_path

    # Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    # Arrange
    Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    Supplier.create(name: 'Fábrica de Camisetas', corporate_name: 'Camisas BR ME', cnpj: '01.000.000/0001-01', 
                    email: 'vendas@camisetas.com')
    User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'usuario@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '12'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '14'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 12 x 8 x 14'
    expect(page).to have_content 'Fornecedor: Cerâmicas Geek'
  end
end
