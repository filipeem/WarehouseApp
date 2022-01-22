FactoryBot.define do
  factory :warehouse do
    name { 'Santos' }
    code { 'SAN' }
    description { 'GAlpão Legal' }
    address { 'Rua do Porto de Santos, 1000' }
    city { 'Santos' }
    state { 'SP' }
    postal_code { '13000-000' }
    total_area { 1000000 }
    useful_area { 90000 }
    
  end
end
