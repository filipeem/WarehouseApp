require 'rails_helper'

describe 'Visitor navigates' do
  it 'using the menu' do
    visit root_path

    expect(page).to have_css('nav a', text: 'Cadastrar novo galpão') 
    expect(page).to have_css('nav a', text: 'Início') 

    within('nav') do
      expect(page).to have_link('Início', href: root_path)
      expect(page).to have_link('Cadastrar novo galpão')
    end
  end
end
