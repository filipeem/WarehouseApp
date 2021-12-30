require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  it 'nome é obrigatório' do
    # Arrange
    warehouse = Warehouse.new(name: '', code: 'MCZ', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'CEP é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'código é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: '', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'descrição é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'CWB', 
                               description: '',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'endereço é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: '', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'cidade é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: '', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'estado é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: '',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'área total é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area:'', useful_area: 4000)
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'área útil é obrigatório' do
    warehouse = Warehouse.new(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: '')
    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
  end

  it 'código não pode ser duplicado' do
    # Arrange
    warehouse = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                 address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                 postal_code: '57050-000',
                                 total_area: 10000, useful_area: 8000)

    warehouse2 = Warehouse.new(name: 'Curitiba', code: 'MCZ', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '87050-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse2.valid?

    # Assert
    expect(result).to eq false
    
  end

  it 'nome não pode ser duplicado' do
    # Arrange
    warehouse = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                 address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                 postal_code: '57050-000',
                                 total_area: 10000, useful_area: 8000)

    warehouse2 = Warehouse.new(name: 'Maceió', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '87050-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse2.valid?

    # Assert
    expect(result).to eq false
    
  end

  context 'cep inválido não pode ser registrado' do
    it 'cep igual a 755' do
      # Arrange
      warehouse = Warehouse.new(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                  address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                  postal_code: '755',
                                  total_area: 10000, useful_area: 8000)

      # Act
      result = warehouse.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep igual a 700000-00' do
      # Arrange
      warehouse = Warehouse.new(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                  address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                  postal_code: '700000-00',
                                  total_area: 10000, useful_area: 8000)

      # Act
      result = warehouse.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep igual a aaaaa-aaa' do
      # Arrange
      warehouse = Warehouse.new(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                  address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                  postal_code: 'aaaaa-aaa',
                                  total_area: 10000, useful_area: 8000)

      # Act
      result = warehouse.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'editar só altera atributo solicitado' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Curitiba', code: 'CWB', 
                               description: 'Ótimo galpão mas é frio',
                               address: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                               postal_code: '45000-000',
                               total_area: 5000, useful_area: 4000)
    warehouse2 = Warehouse.create!(name: 'Maceió', code: 'MCZ', 
                               description: 'galpão em Maceió',
                               address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                               postal_code: '70000-000',
                               total_area: 5000, useful_area: 4000)
    # Act
    warehouse.update(description: 'descrição atualizada')
    result = warehouse.description
    result2 = warehouse2.description

    # Assert
    expect(result).to eq 'descrição atualizada'
    expect(result2).to eq 'galpão em Maceió'
  end

end
