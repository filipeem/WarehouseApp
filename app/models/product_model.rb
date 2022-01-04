class ProductModel < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  has_many :product_items

  before_validation:ensure_sku_is_random

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  validates :name, :supplier, :category, :weight, :height, :length, :width, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }
  validates :weight, :height, :length, :width, numericality: { greater_than: 0 }

  private
    def ensure_sku_is_random
      if sku.nil?
        self.sku = SecureRandom.alphanumeric(20)
      end
    end
end
