require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    it '.dimensions' do
        #Arrange
        p = ProductModel.new(height: '14', width: '10', length: '12')
        #Act
        result = p.dimensions()
        #Assert
        expect(result).to eq '14 x 10 x 12'
    end
    
    it 'nome é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: '', weight: 1, height: 1, length: 1, width: 1, 
                                         supplier: supplier, category: category)
        
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'fornecedor é obrigatório' do
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: '', weight: 1, height: 1, length: 1, width: 1, 
                                         category: category)
        
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Peso é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: '', height: 1, length: 1, width: 1, 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Altura é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: '', length: 1, width: 1, 
                                         category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Comprimento é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: '', width: 1, 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Largura é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: 1, width: '', 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Peso é maior que zero' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: '0', height: 1, length: 1, width: 1, 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Altura é maior que zero' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: '0', length: 1, width: 1, 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Comprimento é maior que zero' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: '0', width: 1, 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'Largura é maior que zero' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: 1, width: '0', 
                                        category: category, supplier: supplier)
        result = product_model.valid?
    
        expect(result).to eq false
    end
    it 'SKU é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1,
                                         supplier: supplier, category: category)
        result = product_model.sku
    
        expect(result).not_to eq nil
    end
    it 'SKU é único' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model1 = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                    sku: '', supplier: supplier, category: category)
        product_model2 = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                    sku: '', supplier: supplier, category: category)
        result1 = product_model1.sku
        result2 = product_model2.sku
    
        expect(result1).not_to eq result2
    end
    it 'SKU tem 20 caracteres' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                    sku: '', supplier: supplier, category: category)

        result = product_model.sku
    
        expect(result.length).to eq 20
    end
    it 'Categoria é obrigatório' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                     supplier: supplier)
                      
        result = product_model.valid?
    
        expect(result).to eq false
    end
end
