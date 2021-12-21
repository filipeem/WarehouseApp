class ProductModel < ApplicationRecord
  belongs_to :supplier

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  validates :name, :supplier, :weight, :height, :length, :width, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }
  validates :weight, :height, :length, :width, numericality: { greater_than: 0 }
end
