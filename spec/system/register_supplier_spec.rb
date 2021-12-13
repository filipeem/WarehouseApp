require 'rails_helper'

describe 'Visitante cadastra um fornecedor' do
  it 'através de um link na tela inicial' do
    # Arrange

    # Act
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

  it 'com sucesso' do
    # Arrange

    # Act
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

  it 'e os campos Nome, Razão Social, CNPJ e e-mail são obrigatórios' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'e-mail', with: ''
    click_on 'Gravar'

    # Assert
    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o fornecedor'
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "CNPJ não pode ficar em branco"
    expect(page).to have_content "e-mail não pode ficar em branco"
  end
  it 'e o CNPJ deve ser único' do
    # Arrange
    Supplier.new(name: 'Blablabla', corporate_name: 'Blablabla Logística Ltda', cnpj: '00.000.000/0001-00', address: 'av. dos Estados',
                  city: 'Porto Alegre', state: 'RS', email: 'contato@blabla.com.br', phone: '(51) 51515151').save()
    # Act
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome', with: 'Teste'
    fill_in 'Razão Social', with: 'Teste Ltda'
    fill_in 'CNPJ', with: '00.000.000/0001-00'
    fill_in 'e-mail', with: 'teste@teste.com'
    click_on 'Gravar'
    # Assert
    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o fornecedor'
    expect(page).to have_content "CNPJ já cadastrado"
  end
end