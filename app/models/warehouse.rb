class Warehouse < ApplicationRecord
  has_many :product_items
  has_and_belongs_to_many :categories
  
  validates :name, :code, :description, :address, :city, :state, :postal_code, :total_area, 
            :useful_area, presence: true
  validates :name, :code, uniqueness: true 
  validates :postal_code, format: { with: /\A\d{5}-\d{3}\z/}
end
