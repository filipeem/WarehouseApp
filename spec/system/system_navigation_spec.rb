require 'rails_helper'

describe 'Visitor navigates' do
  it 'using the menu' do
    visit root_path

    # Assert 1
    expect(page).to have_css('nav a', text: 'Início') 

    # Assert 2
    within('nav') do
      expect(page).to have_link('Início', href: root_path)
    end
  end
end

