require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'successfully' do
      # Arrange
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
        address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
        postal_code: '57050-000',
        total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
          address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
          postal_code: '08050-000',
          total_area: 20000, useful_area: 18000)

      # Act
      get '/api/v1/warehouses' # Metodos de request do RSPEc sempre vao gerar uma variavel response

      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Maceió'
      expect(parsed_response[1]["name"]).to eq 'Guarulhos'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av do Aeroporto'
    end

    it 'empty response' do
      # Arrange

      # Act
      get '/api/v1/warehouses'

      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'successfully' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
                            address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
                            postal_code: '08050-000',
                            total_area: 20000, useful_area: 18000)
      # Act
      get "/api/v1/warehouses/#{warehouse.id}"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Guarulhos'
      expect(parsed_response["code"]).to eq 'GRU'
      expect(parsed_response["city"]).to eq 'Guarulhos'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'warehouse dont exist' do
      # Arrange

      # Act
      get "/api/v1/warehouses/999"

      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'successfully' do
      # Arrange
      
      # Act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{ "name": "Maceió",
                                            "code": "MCZ",
                                            "description": "Ótimo galpão numa linda cidade",
                                            "address": "Avenida dos Galpões, 1000",
                                            "city": "Maceió",
                                            "state": "AL",
                                            "postal_code": "57050-000",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                 headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Maceió'
      expect(parsed_response["code"]).to eq 'MCZ'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
    end

    it 'has required fields' do
      # Arrange
      
      # Act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{ "cidade": "Maceió",
                                            "state": "AL",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

    it 'code is not unique' do
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                        postal_code: '57050-000', total_area: 10000, useful_area: 8000)
      
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/warehouses', params: '{ "name": "Aeroporto Maceió",
                                            "code": "MCZ",
                                            "description": "Ótimo galpão numa linda cidade",
                                            "address": "Avenida dos Galpões, 1000",
                                            "city": "Maceió",
                                            "state": "AL",
                                            "postal_code": "57050-000",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                  headers: headers
      expect(response.status).to eq 422
      expect(response.body).to include 'Código já está em uso'
    end

  end

end