require 'rails_helper'

describe 'Visitor navigates' do
  it 'using the menu' do
    visit root_path

    # Assert 1
    expect(page).to have_css('h1', text: 'Warehouse App') 

    # Assert 2
    within('a#home') do
      expect(page).to have_text('Início')
    end
  end
end

