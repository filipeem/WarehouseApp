require 'rails_helper'

describe 'Visitante edita um produto' do
  it 'visitante não logado não consegue editar' do
    # Arrange
    supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    category = Category.create!(name: 'Cozinha')
    product_model = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                         supplier: supplier, category: category)
    # Act
    visit suppliers_path
    click_on 'Cerâmicas Geek'
    within('button#edit') do
      click_on 'Editar'
    end
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'através de um botão na tela do fornecedor' do
    # Arrange
    supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    category = Category.create!(name: 'Cozinha')
    product_model = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                        supplier: supplier, category: category)
    # Adicionar um usuario e fazer login antes de prosseguir
    user = create(:user)
    # Act
    login_as(user)
    visit suppliers_path
    click_on 'Cerâmicas Geek'
    within('button#edit') do
      click_on 'Editar'
    end

    # Assert
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Peso'
    expect(page).to have_content 'Altura'
    expect(page).to have_content 'Largura'
    expect(page).to have_content 'Profundidade'
    expect(page).to have_content 'Fornecedor'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    # Arrange
    supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    category = Category.create!(name: 'Cozinha')
    product_model = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                         supplier: supplier, category: category)
    # Adicionar um usuario e fazer login antes de prosseguir
    user = create(:user)
    # Act
    login_as(user)
    visit suppliers_path
    click_on 'Cerâmicas Geek'
    within('button#edit') do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Nome Atualizado'
    fill_in 'Peso', with: '3'
    fill_in 'Altura', with: '4'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Produto editado com sucesso'
    expect(page).to have_content '3'
    expect(page).to have_content '4'
    expect(page).to have_content 'Nome Atualizado'
    expect(page).not_to have_content 'Caneca'
    
  end
  it 'e vê erros de validação' do
    # Arrange
    supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    category = Category.create!(name: 'Cozinha')
    product_model = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                         supplier: supplier, category: category)
    # Adicionar um usuario e fazer login antes de prosseguir
    user = create(:user)
    # Act
    login_as(user)
    visit suppliers_path
    click_on 'Cerâmicas Geek'
    within('button#edit') do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: '0'
    fill_in 'Altura', with: '0'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Não foi possível editar o produto'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).not_to have_content 'Produto editado com sucesso'
    
  end

  it 'um usuário consegue trocar o status para inativo' do
    product_model1 = create(:product_model, name:'TV 4k')
    product_model2 = create(:product_model, name:'Geladeira')
    user = create(:user)
    
    login_as(user)
    visit product_models_path
    click_on 'TV 4k'
    click_on 'Inativar'
    

    expect(page).not_to have_content 'TV 4k'
    expect(page).to have_content 'produto inativado com sucesso'
    expect(page).to have_content 'Geladeira'
  end
  it 'um usuário consegue trocar o status para ativo' do
    product_model1 = create(:product_model, name:'TV 4k')
    product_model2 = create(:product_model, name:'Geladeira')
    user = create(:user)
    product_model1.disabled!
    
    login_as(user)
    visit product_models_path
    click_on 'Ver produtos Inativos'
    click_on 'ativar'
    

    expect(page).to have_content 'TV 4k'
    expect(page).to have_content 'produto ativado com sucesso'
    expect(page).to have_content 'Geladeira'
  end
end