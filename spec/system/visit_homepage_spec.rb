require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  # Cenários
  it 'e vê uma mensagem de boas vindas' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de estoques')
  end

  it 'e vê os galpões cadastrados' do
    # 3 As
    # Arrange => Preparar
    Warehouse.new(name: 'Guarulhos', code: 'GRU', description: 'galpão no estado de SP', address: 'rua Fictícia 1010',
                  city: 'Garulhos', state: 'SP', postal_code: '00000-000', total_area: '10000', useful_area: '8000').save()
    Warehouse.new(name: 'Porto Alegre', code: 'POA', description: 'galpão no estado do RS', address: 'rua Fictícia do Sul 1313',
    city: 'Porto Alegre', state: 'RS', postal_code: '90000-000', total_area: '5000', useful_area: '4000').save()
    # Act => Agir ou Executar
    visit root_path

    # Assert => Garantir ou validar ou checar
    expect(page).to have_content('Galpões Cadastrados')
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('POA')
  end

  it 'e não vê todos detalhes do galpão' do
    # Arrange
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_content('Ótimo galpão numa linda cidade')
    expect(page).not_to have_content('Av Fernandes Lima')
    expect(page).not_to have_content('Maceió/AL')
    expect(page).not_to have_content('57050-000')
  end
end