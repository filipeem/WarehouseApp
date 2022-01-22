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

    it 'should generate an SKU' do
        # Arrange
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    
        p = ProductModel.new(name: 'Monitor Gamer', supplier: supplier, weight: '2000',
                             height: '14', width: '10', length: '12')
    
        # Act
        p.save()
    
        # Assert
        expect(p.sku).not_to eq nil
        expect(p.sku.length).to eq 20
    end
    
    it 'should generate a random SKU' do
        # Arrange
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    
        p = ProductModel.new(name: 'Monitor Gamer', supplier: supplier, weight: '2000',
                             height: '14', width: '10', length: '12')
        
        allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'
    
        # Act
        p.save()
        
    
        # Assert
        expect(p.sku).to eq '6WL0esFqq9gQMDGrYBjV'
    end
    
      it 'should not update sku' do
        # Arrange
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
    
        p = ProductModel.new(name: 'Monitor Gamer', supplier: supplier, weight: '2000',
        height: '14', width: '10', length: '12')
        p.save()
        sku = p.sku
        
        # Act
        p.update(name: 'Monitor 4k')
    
        # Assert
        expect(p.name).to eq 'Monitor 4k'
        expect(p.sku).to eq sku
    
      end
    
    it 'SKU é único' do
        allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model1 = ProductModel.create!(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                    supplier: supplier, category: category)
        product_model2 = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                    supplier: supplier, category: category)
        
        result = product_model2.valid?
    
        expect(result).to eq false
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
    it 'edita somente o campo solicitado' do
        supplier = Supplier.create(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
        category = Category.create(name: 'Cozinha')
        product_model1 = ProductModel.new(name: 'Caneca', weight: 1, height: 1, length: 1, width: 1, 
                                     supplier: supplier, category: category)
        product_model2 = ProductModel.new(name: 'Caneca2', weight: 1, height: 1, length: 1, width: 1, 
                                     supplier: supplier, category: category)
        product_model1.update(name: 'CanecaUpdate')
                      
        result = product_model1.name
        result2 = product_model2.name
    
        expect(result).to eq 'CanecaUpdate'
        expect(result2).to eq 'Caneca2'
    end
    it 'modelo de produto pode ser desativado' do
        product_model = create(:product_model)

        result = product_model.disabled!

        expect(product_model.status).to eq 'disabled' 
    end
    
end
