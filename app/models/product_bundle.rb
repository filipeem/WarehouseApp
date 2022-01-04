class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_model, through: :product_bundle_items 

  validates :name, :sku, presence: true
  validates :sku, uniqueness: true

  before_validation:ensure_sku_is_random
  private
    def ensure_sku_is_random
      if sku.nil?
        self.sku = SecureRandom.alphanumeric(20)
      end
    end
end
