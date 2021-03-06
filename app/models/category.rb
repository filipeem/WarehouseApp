class Category < ApplicationRecord
  has_many :product_models
  has_and_belongs_to_many :warehouses
  
  validates :name, presence: true
end
