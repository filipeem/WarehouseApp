require 'rails_helper'

describe 'Visitante cadastra um fornecedor' do
  it 'visitante não vê o menu' do
    visit root_path
    expect(page).not_to have_link('Cadastrar novo fornecedor')
  end

  it 'visitante não acessa diretamente o formulário' do
    visit new_supplier_path

    expect(current_path).to eq new_user_session_path
  end
  it 'através de um link na tela inicial' do
    # Arrange
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    # Assert
    expect(page).to have_content 'Novo Fornecedor'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'e-mail'
    expect(page).to have_field 'Telefone'
  end

  it 'com falha' do
    # Arrange
    user = create(:user)
    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome', with: 'BlaBlaBla Logística'
    fill_in 'Razão Social', with: 'BlaBlaBla Logística e transportes LTDA'
    fill_in 'Endereço', with: 'Av dos Estados'
    fill_in 'Cidade', with: 'Porto Alegre'
    fill_in 'Estado', with: 'RS'
    fill_in 'CNPJ', with: ''
    fill_in 'e-mail', with: 'contato@blablabla.com.br'
    fill_in 'Telefone', with: '(51) 5555.5555'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content('Não foi possível gravar o fornecedor')
    
  end
  it 'com sucesso' do
    # Arrange
    user = create(:user)
    # Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome', with: 'BlaBlaBla Logística'
    fill_in 'Razão Social', with: 'BlaBlaBla Logística e transportes LTDA'
    fill_in 'Endereço', with: 'Av dos Estados'
    fill_in 'Cidade', with: 'Porto Alegre'
    fill_in 'Estado', with: 'RS'
    fill_in 'CNPJ', with: '00.000.000/0001-00'
    fill_in 'e-mail', with: 'contato@blablabla.com.br'
    fill_in 'Telefone', with: '(51) 5555.5555'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content('BlaBlaBla Logística')
    expect(page).to have_content('BlaBlaBla Logística e transportes LTDA')
    expect(page).to have_content('Av dos Estados')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('RS')
    expect(page).to have_content('00.000.000/0001-00')
    expect(page).to have_content('contato@blablabla.com.br')
    expect(page).to have_content('(51) 5555.5555')
    expect(page).to have_content 'Fornecedor registrado com sucesso'
  end
end