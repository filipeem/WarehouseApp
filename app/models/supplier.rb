class Supplier < ApplicationRecord
  validates :name, :corporate_name, :cnpj, :email, presence: true
end
