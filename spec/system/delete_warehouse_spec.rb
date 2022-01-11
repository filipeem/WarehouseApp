require 'rails_helper'

describe 'Visitante deleta um galpão' do
  it 'usuário não logado não consegue deletar galpão' do
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', postal_code: '57050-000',
                          total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'São Paulo', code: 'CGH', description: 'Galpão na capital paulista',
                          address: 'Av Washington Luiz', city: 'São Paulo', state: 'SP',
                          postal_code: '04000-000', total_area: 10000, useful_area: 8000)
    w3 = Warehouse.create!(name: 'São Luiz', code: 'SLZ', description: 'Galpão no Maranhão', 
                          address: 'Av dos Libaneses,', city: 'São Luiz', state: 'MA',
                          postal_code: '65000-000', total_area: 10000, useful_area: 8000)
    
    visit root_path
    click_on 'Maceió'
    within('button') do
      click_on 'Apagar'
    end
    
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um botão na tela inicial' do
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', postal_code: '57050-000',
                          total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'São Paulo', code: 'CGH', description: 'Galpão na capital paulista',
                          address: 'Av Washington Luiz', city: 'São Paulo', state: 'SP',
                          postal_code: '04000-000', total_area: 10000, useful_area: 8000)
    w3 = Warehouse.create!(name: 'São Luiz', code: 'SLZ', description: 'Galpão no Maranhão', 
                          address: 'Av dos Libaneses,', city: 'São Luiz', state: 'MA',
                          postal_code: '65000-000', total_area: 10000, useful_area: 8000)
    user = User.create!(email: 'usuario@email.com', password: '12345678')

    visit root_path
    login_as(user)
    click_on 'Maceió'
    within('button') do
      click_on 'Apagar'
    end
    
    expect(page).not_to have_content 'Maceió'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'São Luiz'
  end

end