class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_model, through: :product_bundle_items 

  validates :name, presence: true
end
