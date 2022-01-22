FactoryBot.define do
  factory :product_model do
    name { 'TV OLED 50 polegadas'}
    height { '74' }
    width { '123' }
    length { '12' }
    weight { 16000 }
    supplier
    category
  end
end