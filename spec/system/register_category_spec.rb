require 'rails_helper'

describe 'Visitante cadastra uma categoria de produto' do
  it 'visitante não vê o menu' do
    # Um visitante, não autenciado, não pode acessar o formulario de galpões
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).not_to have_link('Cadastrar nova categoria')
  end

  it 'visitante não acessa diretamente o formulário' do
    # Arrange

    # Act
    visit new_category_path

    # Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'através de um link na tela inicial' do
    # Arrange
    # Adicionar um usuario e fazer login antes de prosseguir
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar nova categoria'

    # Assert
    expect(page).to have_content 'Nova Categoria'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar nova categoria'
    fill_in 'Nome', with: 'Eletrônicos'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content('Eletrônicos')
    expect(page).to have_content 'Categoria registrada com sucesso'
  end

  it 'com falha' do
    # Arrange
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar nova categoria'
    fill_in 'Nome', with: ''
    click_on 'Gravar'

    # Assert
    expect(page).to have_content('Não foi possível registrar a categoria')
    expect(page).not_to have_content 'Categoria registrada com sucesso'
  end

end