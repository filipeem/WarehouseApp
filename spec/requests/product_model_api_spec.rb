require 'rails_helper'

describe 'ProductModel API' do
  context 'GET /api/v1/product_models' do
    it 'successfully' do
      # Arrange
      supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      category = Category.create!(name: 'Cozinha')

      ProductModel.create!(name: 'Caneca Star Wars', weight: 50, height: 10, length: 6, width: 6, 
                                          supplier: supplier, category: category)
      ProductModel.create!(name: 'Garrafa Térmica', weight: 80, height: 20, length: 5, width: 5, 
                                          supplier: supplier, category: category)

      # Act
      get '/api/v1/product_models'

      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Caneca Star Wars'
      expect(parsed_response[1]["name"]).to eq 'Garrafa Térmica'
      expect(parsed_response).not_to include 'created_at'
      expect(parsed_response).not_to include 'updated_at'
    end

    it 'empty response' do
      # Arrange

      # Act
      get '/api/v1/product_models'

      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_models/:id' do
    it 'successfully' do
      # Arrange
      supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      category = Category.create!(name: 'Cozinha')

      p = ProductModel.create!(name: 'Caneca Star Wars', weight: 50, height: 10, length: 6, width: 6, 
                           supplier: supplier, category: category)
      # Act
      get "/api/v1/product_models/#{p.id}"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Caneca Star Wars'
      expect(parsed_response["weight"]).to eq 50
      expect(parsed_response["height"]).to eq 10
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'product_model doesnt exists' do
      # Arrange

      # Act
      get "/api/v1/product_models/999"

      # Assert
      expect(response.status).to eq 404
    end

    it 'database error - 500' do
      # Arrange
      supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      category = Category.create!(name: 'Cozinha')

      p = ProductModel.create!(name: 'Caneca Star Wars', weight: 50, height: 10, length: 6, width: 6, 
                               supplier: supplier, category: category)
      allow(ProductModel).to receive(:find).with(p.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
      # Act
      get("/api/v1/product_models/#{p.id}")

      # Assert
      expect(response.status).to eq 500
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Não foi possível conectar ao banco de dados'
    end

  end

  context 'POST /api/v1/product_models' do
    it 'successfully' do
      # Arrange
      supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      category = Category.create!(name: 'Cozinha')
      # Act
      params = JSON.generate({'name' => 'Caneca Star Wars', 'weight' => '50', 'height' => '10', 'length' => '6',
                'width' => '6', 'supplier_id' => supplier.id, 'category_id' => category.id })
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_models', params: params, headers: headers
      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Caneca Star Wars'
      expect(parsed_response["supplier_id"]).to eq supplier.id
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end

    it 'has required fields' do
      # Arrange
      supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      category = Category.create!(name: 'Cozinha')
      # Act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/product_models', params: '{ "name": "",
                                            "weight": "50",
                                            "height": "10",
                                            "length": "6",
                                            "width": "6",
                                            "supplier": {"id":"1", "name": "Cerâmicas Geek", "corporate_name": "Geek Comercio de Ceramicas LTDA","cnpj": "00.000.000/0002-00", "email": "contato@geek.com" },
                                            "category": {"id":"1","name": "Cozinha"}}',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

  end
end