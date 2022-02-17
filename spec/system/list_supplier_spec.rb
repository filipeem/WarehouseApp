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
    supplier = Supplier.create!(name: 'Fábrica Geek', corporate_name: 'Geek Comercio de Presentes LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Spider Man, 3',
                        email: 'geekceramicas@gmail.com', phone: '31 3456-7890')
    category = Category.create!(name:'Cozinha')
    category2 = Category.create!(name:'Brinquedos')
    ProductModel.new(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                        weight: 300, supplier: supplier, category: category).save()
    ProductModel.new(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                        weight: 400, supplier: supplier, category: category2).save()

    # Act -> Agir / Executar algo
    visit root_path
    click_on 'Fornecedores'
    click_on 'Fábrica Geek'
    # Assert -> Validar / Esperar que algo aconteça
    expect(page).to have_css('h2', text: 'Fábrica Geek')
    expect(page).to have_css('h2', text: 'Produtos deste fornecedor:')
    expect(page).to have_content('Caneca Star Wars')
    expect(page).to have_content('Pelúcia Dumbo')
  end
end