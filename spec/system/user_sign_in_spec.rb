require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    # Arrange
    user = create(:user, email: 'usuario@email.com')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'usuario@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'usuario@email.com'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  it 'e faz logout' do
    # Arrange
    user = create(:user, email: 'usuario@email.com')
    # Act
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'usuario@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'usuario@email.com'
  end
end
