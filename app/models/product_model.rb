class ProductModel < ApplicationRecord
  belongs_to :supplier

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  validates :name, :supplier, :weight, :height, :length, :width, :sku, presence: true
end
