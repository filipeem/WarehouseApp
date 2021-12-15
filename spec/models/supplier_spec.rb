require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it 'nome é obrigatório' do
    supplier = Supplier.new(name: '', corporate_name: 'Blablabla Logística Ltda', 
               cnpj: '00.000.000/0001-00', address: 'av. dos Estados', city: 'Porto Alegre', state: 'RS',
               email: 'contato@blabla.com.br', phone: '(51) 51515151')
    
    result = supplier.valid?

    expect(result).to eq false
  end
  it 'corporate_name é obrigatório' do
    supplier = Supplier.new(name: 'Blablabla', corporate_name: '', 
               cnpj: '00.000.000/0001-00', address: 'av. dos Estados', city: 'Porto Alegre', state: 'RS',
               email: 'contato@blabla.com.br', phone: '(51) 51515151')
    
    result = supplier.valid?

    expect(result).to eq false
  end
  it 'CNPJ é obrigatório' do
    supplier = Supplier.new(name: 'Blablabla', corporate_name: 'Blablabla Logística Ltda', 
               cnpj: '', address: 'av. dos Estados', city: 'Porto Alegre', state: 'RS',
               email: 'contato@blabla.com.br', phone: '(51) 51515151')
    
    result = supplier.valid?

    expect(result).to eq false
  end
  it 'E-mail é obrigatório' do
    supplier = Supplier.new(name: 'Blablabla', corporate_name: 'Blablabla Logística Ltda', 
               cnpj: '00.000.000/0001-00', address: 'av. dos Estados', city: 'Porto Alegre', state: 'RS',
               email: '', phone: '(51) 51515151')
    
    result = supplier.valid?

    expect(result).to eq false
  end
  it 'CNPJ deve ser único' do
    supplier = Supplier.create(name: 'Blablabla', corporate_name: 'Blablabla Logística Ltda', 
               cnpj: '00.000.000/0001-00', address: 'av. dos Estados', city: 'Porto Alegre', state: 'RS',
               email: 'contato@blabla.com.br', phone: '(51) 51515151')
    supplier2 = Supplier.new(name: 'Xpto', corporate_name: 'Xpto comércio Ltda', 
               cnpj: '00.000.000/0001-00', address: 'av. dos Presidente', city: 'Porto Alegre', state: 'RS',
               email: 'contato@xpto.com.br', phone: '(55) 55555555')
    
    result = supplier2.valid?

    expect(result).to eq false
  end
  context 'CNPJ inválido não pode ser registrado' do
    it 'CNPJ menor que 18 caracteres' do
      supplier = Supplier.new(name: 'Xpto', corporate_name: 'Xpto comércio Ltda', 
               cnpj: '00.000.000/0001', address: 'av. dos Presidente', city: 'Porto Alegre', state: 'RS',
               email: 'contato@xpto.com.br', phone: '(55) 55555555')
      result = supplier.valid?

      expect(result).to eq false
    end
    it 'CNPJ maior que 18 caracteres' do
      supplier = Supplier.new(name: 'Xpto', corporate_name: 'Xpto comércio Ltda', 
               cnpj: '000.000.000/0001-00', address: 'av. dos Presidente', city: 'Porto Alegre', state: 'RS',
               email: 'contato@xpto.com.br', phone: '(55) 55555555')
      result = supplier.valid?

      expect(result).to eq false
    end
    it 'CNPJ sem formatação' do
      supplier = Supplier.new(name: 'Xpto', corporate_name: 'Xpto comércio Ltda', 
               cnpj: '00000000000100', address: 'av. dos Presidente', city: 'Porto Alegre', state: 'RS',
               email: 'contato@xpto.com.br', phone: '(55) 55555555')
      result = supplier.valid?

      expect(result).to eq false
    end
  end
end
