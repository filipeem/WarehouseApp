class Supplier < ApplicationRecord
  validates :name, :corporate_name, :cnpj, :email, presence: true
  validates :cnpj, uniqueness:{ message: ' já cadastrado'} 
end
