require 'rails_helper'

describe 'Requests', type: :request do
  context 'warehouses' do
    it 'should refuse warehouse creation if unauthenticated' do
      # Arrange

      # Act
      post '/warehouses'

      # Assert
      expect(response.status).to eq 302
      expect(response.redirect_url).to eq new_user_session_url
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'should refuse warehouse creation if unauthenticated - v2' do
      # Arrange

      # Act
      post '/warehouses'
      follow_redirect!

      # Assert
      expect(response.body).to include 'Entrar'
    end
  end
  context 'product_model' do
    it 'should refuse product_model creation if unauthenticated' do
      # Arrange

      # Act
      post '/product_models'
      follow_redirect!

      # Assert
      expect(response.body).to include 'Entrar'
    end
  end
  context 'supplier' do
    it 'should refuse supplier creation if unauthenticated' do
      # Arrange

      # Act
      post '/suppliers'
      follow_redirect!

      # Assert
      expect(response.body).to include 'Entrar'
    end
  end
end
