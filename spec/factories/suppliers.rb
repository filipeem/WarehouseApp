FactoryBot.define do
  factory :supplier do
    name { "Samsung" }
    corporate_name { 'Samsung do BR LTDA' }
    cnpj { '85.935.972/0001-20' }
    address { 'Av Industrial, 1000, São Paulo' }
    email { 'financeiro@samsung.com.br' }
    phone { '11 12345-6789' }
  end
end
