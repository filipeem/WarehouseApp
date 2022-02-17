require 'rails_helper'

describe 'Vistante abre a tela inicial' do
  it 'e lista todas categorias cadastradas' do
    supplier = Supplier.create!(name: 'Fábrica Geek', corporate_name: 'Geek Comercio de Presentes LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Spider Man, 3',
                        email: 'geekceramicas@gmail.com', phone: '31 3456-7890')
    category = Category.create!(name:'Cozinha')
    category2 = Category.create!(name:'Brinquedos')
    ProductModel.new(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                        weight: 300, supplier: supplier, category: category).save()
    ProductModel.new(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                        weight: 400, supplier: supplier, category: category2).save()
    # Act => Agir ou Executar
    visit root_path
    click_on 'Categorias'
    # Assert => Garantir ou validar ou checar
    expect(page).to have_content('Categorias Cadastradas')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('Brinquedos')
  end

  it 'e vê todos produtos de uma categoria' do
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
    click_on 'Categorias'
    click_on 'Brinquedos'
    # Assert -> Validar / Esperar que algo aconteça
    expect(page).to have_css('h2', text: 'Brinquedos')
    expect(page).to have_css('h2', text: 'Produtos desta categoria:')
    expect(page).not_to have_content('Caneca Star Wars')
    expect(page).to have_content('Pelúcia Dumbo')
  end
end