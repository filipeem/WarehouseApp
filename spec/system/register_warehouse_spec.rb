require 'rails_helper'

describe 'Visitante cadastra um galpão' do
  it 'visitante não vê o menu' do
    # Um visitante, não autenciado, não pode acessar o formulario de galpões
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).not_to have_link('Cadastrar novo galpão')
  end

  it 'visitante não acessa diretamente o formulário' do
    # Arrange

    # Act
    visit new_warehouse_path

    # Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'através de um link na tela inicial' do
    # Arrange
    # Adicionar um usuario e fazer login antes de prosseguir
    User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'usuario@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Cadastrar novo galpão'

    # Assert
    expect(page).to have_content 'Novo Galpão'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    # Arrange
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
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão mineiro com o pé no Rio'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão mineiro com o pé no Rio')
    expect(page).to have_content('Av Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36000-000')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content 'Galpão registrado com sucesso'
  end

end