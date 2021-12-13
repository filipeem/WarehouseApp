require 'rails_helper'

describe 'Visitante cadastra um galpão' do
  it 'através de um link na tela inicial' do
    # Arrange

    # Act
    visit root_path
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

    # Act
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

  it 'e todos campos são obrigatórios' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área Total', with: ''
    fill_in 'Área Útil', with: ''
    click_on 'Gravar'

    # Assert
    expect(page).not_to have_content 'Galpão registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o galpão'
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Código não pode ficar em branco"
    expect(page).to have_content "Endereço não pode ficar em branco"
    expect(page).to have_content "Cidade não pode ficar em branco"
    expect(page).to have_content "Estado não pode ficar em branco"
    expect(page).to have_content "CEP não pode ficar em branco"
    expect(page).to have_content "Área Total não pode ficar em branco"
    expect(page).to have_content "Área Útil não pode ficar em branco"
  end
  it 'e o nome e código são únicos' do
    # Arrange
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    # Act
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: 'Maceió'
    fill_in 'Código', with: 'MCZ'
    fill_in 'Descrição', with: 'Ótimo galpão numa linda cidade'
    fill_in 'Endereço', with: 'Av Fernandes Lima'
    fill_in 'Cidade', with: 'Maceió'
    fill_in 'Estado', with: 'AL'
    fill_in 'CEP', with: '57050-000'
    fill_in 'Área Total', with: '10000'
    fill_in 'Área Útil', with: '8000'
    click_on 'Gravar'
    # Assert
    expect(page).not_to have_content 'Galpão registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o galpão'
    expect(page).to have_content "Nome já está em uso"
    expect(page).to have_content "Código já está em uso"
  end
end