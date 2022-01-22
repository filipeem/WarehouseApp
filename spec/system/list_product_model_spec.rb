require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  it 'e lista todos os modelos de produto' do
    #Arrange
    supplier = Supplier.create!(name: 'Fábrica Geek', corporate_name: 'Geek Comercio de Presentes LTDA',
                        cnpj: '51.905.325/0001-54', address: 'Avenida Spider Man, 3',
                        email: 'geekceramicas@gmail.com', phone: '31 3456-7890')
    category = Category.create!(name:'Cozinha')
    category2 = Category.create!(name:'Brinquedos')
    ProductModel.new(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                        weight: 300, supplier: supplier, category: category).save()
    ProductModel.new(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                        weight: 400, supplier: supplier, category: category2).save()
    # Act
    visit root_path
    click_on 'Ver Produtos'
    # Assert 
    expect(page).to have_content('Produtos Cadastrados')
    expect(page).to have_content('Caneca Star Wars')
    expect(page).to have_content('Pelúcia Dumbo')
  
  end

  it 'Usuário logado vê modelos de produto inativos' do
    product_model1 = create(:product_model, name:'TV 4k')
    product_model2 = create(:product_model, name:'Geladeira')
    product_model1.disabled!
    user = create(:user)
  
    login_as(user)
    visit product_models_path
    click_on 'Ver produtos Inativos'

    expect(page).to have_content('TV 4k')
    expect(page).to have_content('inativo')
  end
end