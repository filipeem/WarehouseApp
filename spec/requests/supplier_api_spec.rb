require 'rails_helper'

describe 'Supplier API' do
  context 'GET /api/v1/suppliers' do
    it 'successfully' do
      # Arrange
      Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      Supplier.create!(name: 'Vinícola Miolo', corporate_name: 'Miolo Fábrica de Bebidas LTDA',
                                    cnpj: '51.905.325/0001-54', address: 'Avenida Cabernet, 100',
                                    email: 'contato@miolovinhos.com', phone: '54 1234-5678')

      # Act
      get '/api/v1/suppliers'

      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Cerâmicas Geek'
      expect(parsed_response[1]["name"]).to eq 'Vinícola Miolo'
      expect(parsed_response).not_to include 'created_at'
      expect(parsed_response).not_to include 'updated_at'
    end

    it 'empty response' do
      # Arrange

      # Act
      get '/api/v1/suppliers'

      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/suppliers/:id' do
    it 'successfully' do
      # Arrange
      supplier = Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
                                    cnpj: '00.000.000/0002-00', email: 'contato@geek.com')
      # Act
      get "/api/v1/suppliers/#{supplier.id}"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Cerâmicas Geek'
      expect(parsed_response["corporate_name"]).to eq 'Geek Comercio de Ceramicas LTDA'
      expect(parsed_response["cnpj"]).to eq '00.000.000/0002-00'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'supplier doesnt exists' do
      # Arrange

      # Act
      get "/api/v1/suppliers/999"

      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/suppliers' do
    it 'successfully' do
      # Arrange
     
      # Act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ "name": "Samsung",
                                            "corporate_name": "SAMSUNG ELETRONICA DA AMAZONIA LTDA",
                                            "cnpj": "00.280.273/0001-37",
                                            "email": "financeiro@samsung.com.br"}',
                                 headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Samsung'
      expect(parsed_response["cnpj"]).to eq '00.280.273/0001-37'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end

    it 'has required fields' do
      # Arrange
      
      # Act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ "name": "",
                                            "corporate_name": "SAMSUNG ELETRONICA DA AMAZONIA LTDA",
                                            "cnpj": "00.280.273/0001-37",
                                            "email": "financeiro@samsung.com.br"}',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

    it 'CNPJ is unique' do
      # Arrange
      Supplier.create!(name: 'Cerâmicas Geek', corporate_name: 'Geek Comercio de Ceramicas LTDA', 
      cnpj: '00.280.273/0001-37', email: 'contato@geek.com')
      # Act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ "name": "Samsung",
                                            "corporate_name": "SAMSUNG ELETRONICA DA AMAZONIA LTDA",
                                            "cnpj": "00.280.273/0001-37",
                                            "email": "financeiro@samsung.com.br"}',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'CNPJ  já cadastrado'
    end

  end
end