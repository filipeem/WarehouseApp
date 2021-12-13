class Warehouse < ApplicationRecord
  validates :name, :code, :description, :address, :city, :state, :postal_code, :total_area, 
            :useful_area, presence: true
  validates :name, :code, uniqueness: true 
  validates :postal_code, format: { with: /[0-9]{5}-[0-9]{3}/}
end
