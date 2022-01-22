FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end
  sequence :cnpj do |n|
    "00.000.000/#{n}#{n}#{n}#{n}-00"
  end
end
