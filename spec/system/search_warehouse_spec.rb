require 'rails_helper'

describe 'Usuario busca galpões' do
  it 'através da tela inicial' do
    # Arrange
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'São Paulo', code: 'CGH', description: 'Galpão na capital paulista',
                     address: 'Av Washington Luiz', city: 'São Paulo', state: 'SP',
                     postal_code: '04000-000',
                     total_area: 10000, useful_area: 8000)
    w3 = Warehouse.create!(name: 'São Luiz', code: 'SLZ', description: 'Galpão na capital paulista',
                     address: 'Av dos Libaneses,', city: 'São Luiz', state: 'MA',
                     postal_code: '65000-000',
                     total_area: 10000, useful_area: 8000)
    
    # Act
    visit root_path
    fill_in 'Pesquisa', with: 'São'
    click_on 'Buscar' 

    # Assert
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'São Luiz'
    expect(page).not_to have_content 'Maceió'
  end
end