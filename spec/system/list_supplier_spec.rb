require 'rails_helper'

describe 'Vistante abre a tela inicial' do
  it 'e lista todos fornecedores cadastrados' do
    Supplier.new(name: 'Blablabla', corporate_name: 'Blablabla Logística Ltda', cnpj: '00.000.000/0001-00', address: 'av. dos Estados',
                  city: 'Porto Alegre', state: 'RS', email: 'contato@blabla.com.br', phone: '(51) 51515151').save()
    Supplier.new(name: 'Teste', corporate_name: 'Teste e Associados S/c', cnpj: '01.001.000/0002-10', 
                  email: 'contato@teste.com.br', phone: '(55) 55555555').save()
    # Act => Agir ou Executar
    visit root_path
    click_on 'Fornecedores'
    # Assert => Garantir ou validar ou checar
    expect(page).to have_content('Fornecedores Cadastrados')
    expect(page).to have_content('Blablabla')
    expect(page).to have_content('contato@blabla.com.br')
    expect(page).to have_content('Teste')
    expect(page).to have_content('contato@teste.com.br')
  end

  it 'e vê todos dados cadastrados de um fornecedor' do
    # Arrange -> Preparar o banco de dados
    Supplier.new(name: 'Blablabla', corporate_name: 'Blablabla Logística Ltda', cnpj: '00.000.000/0001-00', address: 'av. dos Estados',
                  city: 'Porto Alegre', state: 'RS', email: 'contato@blabla.com.br', phone: '(51) 51515151').save()
    # Act -> Agir / Executar algo
    visit root_path
    click_on 'Fornecedores'
    click_on 'Blablabla'
    # Assert -> Validar / Esperar que algo aconteça
    expect(page).to have_content('Blablabla')
    expect(page).to have_content('Blablabla Logística Ltda')
    expect(page).to have_content('00.000.000/0001-00')
    expect(page).to have_content('av. dos Estados')
    expect(page).to have_content('Porto Alegre/RS')
    expect(page).to have_content('contato@blabla.com.br')
    expect(page).to have_content('(51) 51515151')
  end
end