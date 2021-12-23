require 'rails_helper'

describe 'Visitante edita um galpão' do
  it 'visitante não logado não consegue editar' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    visit root_path
    within('button') do
      click_on 'Editar'
    end
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um botão na tela inicial' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Adicionar um usuario e fazer login antes de prosseguir
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    within('button') do
      click_on 'Editar'
    end

    # Assert
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Código'
    expect(page).to have_content 'Descrição'
    expect(page).to have_content 'Área Total'
    expect(page).to have_content 'Área Útil'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Adicionar um usuario e fazer login antes de prosseguir
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    within('button') do
      click_on 'Editar'
    end
    fill_in 'Descrição', with: 'Esta descrição foi atualizada'
    fill_in 'Área Total', with: '4000'
    fill_in 'Área Útil', with: '2500'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Galpão editado com sucesso'
    expect(page).to have_content 'Curitiba'
    expect(page).to have_content 'CWB'
    expect(page).to have_content 'Esta descrição foi atualizada'
    expect(page).to have_content '4000'
    expect(page).to have_content '2500'
    expect(page).not_to have_content 'Ótimo galpão mas é frio'
    
  end
  it 'e vê erros de validação' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Adicionar um usuario e fazer login antes de prosseguir
    user = User.create!(email: 'usuario@email.com', password: '12345678')
    # Act
    login_as(user)
    visit root_path
    within('button') do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    fill_in 'CEP', with: '1'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Não foi possível editar o galpão'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CEP não é válido'
    expect(page).not_to have_content 'Galpão editado com sucesso'
    
  end

end