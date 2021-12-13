class Supplier < ApplicationRecord
  validates :name, :corporate_name, :cnpj, :email, presence: true
  validates :cnpj, uniqueness:{ message: ' já cadastrado'} 
  validates :cnpj, length: { is: 18 }
end
